# xl-winhttp-helper - WinHTTP ����̃R�[���o�b�N���󂯎��w���p�[ DLL

## DESCRIPTION

WinHTTP �̃R�[���o�b�N�� WinHTTP ���̃X���b�h����Ă΂��B

c:defun-c-callable �ō쐬�����R�[���o�b�N�֐��̓X���b�h�Z�[�t�ł͂Ȃ�����(?)�A
WinHTTP �ɓn���ƃR�[���o�b�N���� xyzzy ���N���b�V������ꍇ������B

�����ŁAWinHTTP ����̃R�[���o�b�N���󂯎��֐��� C++ �ō쐬����B
���̃R�[���o�b�N�֐��ł͎󂯎���������� DLL ���̃L���[�ɕۑ�����B

xyzzy ����� start-timer �Ń|�[�����O���ăL���[�̏�Ԃ��Ď����A
��Ԃ̕ύX����������L���[���������ǂ݂����ď�������悤�ɂ���B

<a href="https://cacoo.com/diagrams/SEHjYu1oCSCjpgkP">
<img src="https://cacoo.com/diagrams/SEHjYu1oCSCjpgkP-5783A.png">
</a>


## REMARKS

### �|�[�����O�Ԋu

start-timer ���g�����|�[�����O�ɂ��C�x���g�Ď��� xml-http-request �ł�
�s�Ȃ��Ă���B

xml-http-request �ł� 0.3 �b�Ԋu�ŊĎ����Ă���Bxml-http-request �ł�
XMLHTTP �I�u�W�F�N�g���Ń��X�|���X�����ׂĎ�M������ɏ�Ԃ��ς�邽�߁A
0.3 �b�Ԋu�ł����e�͈͓��̒x�����Ǝv����B

WinHTTP �ł̓f�[�^����M���邽�тɃR�[���o�b�N���Ăяo����A
�R�[���o�b�N������ WinHttpReadData �Ȃǂ��ĂьĂяo���Ȃ���
���̃C�x���g�����΂��Ȃ��B

���̂��߁Axml-http-request �Ɠ��� 0.3 �b�Ԋu�ł͒x�������e�ł��Ȃ�
�͈͂ɂȂ�\�������邽�߁A�|�[�����O�Ԋu�̓A�v�����ƂɎw��\�Ƃ���B
