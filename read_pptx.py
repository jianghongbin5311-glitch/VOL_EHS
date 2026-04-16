import zipfile
import xml.etree.ElementTree as ET

pptx_path = r'c:\Users\FZP28D\Desktop\AI Created\Kevin_LessonLearn\VOL_Pro_LL\LL系统需求文档-20260310.pptx'

z = zipfile.ZipFile(pptx_path)
slides = [f for f in z.namelist() if f.startswith('ppt/slides/slide') and f.endswith('.xml')]
slides.sort(key=lambda x: int(x.replace('ppt/slides/slide', '').replace('.xml', '')))

text_content = []
for i, slide in enumerate(slides[:15]):
    text_content.append(f'--- Slide {i+1} ---')
    xml_data = z.read(slide)
    root = ET.fromstring(xml_data)
    for node in root.iter():
        if node.tag.endswith('}t') and node.text:
            text_content.append(node.text)

with open('pptx_content.txt', 'w', encoding='utf-8') as f:
    f.write('\n'.join(text_content))
