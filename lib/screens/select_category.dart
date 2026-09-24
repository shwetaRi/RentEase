import 'package:flutter/material.dart';
import 'package:project_rent_ease/screens/property_info_page.dart';

class SelectCategory extends StatefulWidget {
  const SelectCategory({super.key});

  @override
  State<SelectCategory> createState() => _SelectCategoryState();
}

class _SelectCategoryState extends State<SelectCategory> {
  String? selectedCategory;
  void _selectAndNavigate(String categoryName){
    setState(() {
      selectedCategory = categoryName;
    });
    Future.delayed(Duration(milliseconds: 250),(){
    Navigator.push(context,
        MaterialPageRoute(
            builder: (context)=> PropertyInfoPage(
                selectedCategory:categoryName
            )
    )
    );
    }
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title:Text(
          'Select Category',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 20,
            color: Color(0xff000000),
          ),
        ),
      ),
      body:
           Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
               SizedBox(height: 25),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 29),
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 45,
                        height: 45,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xFF90EE90)
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(3.5),
                          child: Text(
                            '1',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xFFFFFFFF),
                              fontWeight: FontWeight.w600,
                              fontSize: 25,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: 45,
                        height: 45,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xFF808080)
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(3.5),
                          child: Text(
                            '2',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xFFFFFFFF),
                              fontWeight: FontWeight.w600,
                              fontSize: 25,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: 45,
                        height: 45,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xFF808080)
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(3.5),
                          child: Text(
                            '3',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xFFFFFFFF),
                              fontWeight: FontWeight.w600,
                              fontSize: 25,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: 45,
                        height: 45,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xFF808080)
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(3.5),
                          child: Text(
                            '4',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xFFFFFFFF),
                              fontWeight: FontWeight.w600,
                              fontSize: 25,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 48),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                            GestureDetector(
                              onTap: () => _selectAndNavigate('Family'),
                              child: Stack(
                                children: [
                                  Container(
                                    width: 115,
                                    height: 133,
                                    decoration: BoxDecoration(
                                      color: selectedCategory =='Family'
                                          ? Color(0xFFDCDCDC)
                                          : Color(0xFFF2F8FF),
                                      borderRadius: BorderRadius.circular(16),
                                      border: Border.all(
                                        color: selectedCategory=='Family'
                                            ? Color(0xFF00C897)
                                            : Color(0xFFE0E0E0),
                                        width: selectedCategory=='Family' ? 2 : 1,
                                      )
                                    ),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Image(image: AssetImage('assets/icons/Family.png'),
                                        height: 48,
                                        width: 48
                                        ),
                                        SizedBox(height: 5),
                                        Text(
                                          'Family',
                                          style: TextStyle(
                                            fontSize: 13,
                                              fontWeight: FontWeight.w600,
                                              color: Color(0xFF000000)
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  if(selectedCategory == 'Family')
                                    Positioned(
                                      right: 8,
                                      bottom: 8,
                                      child: Container(
                                        width: 20,
                                        height: 20,
                                        decoration: BoxDecoration(
                                          color: Color(0xFF00C897),
                                          shape: BoxShape.circle
                                        ),
                                        child: Icon(
                                          Icons.check,
                                          color: Colors.white,
                                        ),
                                      ),
                                    )
                                ],
                              ),
                            ),
                        GestureDetector(
                          onTap: () => _selectAndNavigate('Bachelor'),
                          child: Stack(
                            children: [
                              Container(
                                width: 115,
                                height: 133,
                                decoration: BoxDecoration(
                                    color: selectedCategory =='Bachelor'
                                        ? Color(0xFFDCDCDC)
                                        : Color(0xFFF2F8FF),
                                    borderRadius: BorderRadius.circular(16),
                                    border: Border.all(
                                      color: selectedCategory=='Bachelor'
                                          ? Color(0xFF00C897)
                                          : Color(0xFFE0E0E0),
                                      width: selectedCategory=='Bachelor' ? 2 : 1,
                                    )
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image(image: AssetImage('assets/icons/Bachelor.png'),
                                        height: 48,
                                        width: 48
                                    ),
                                    SizedBox(height: 5),
                                    Text(
                                      'Bachelor',
                                      style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w600,
                                          color: Color(0xFF000000)
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              if(selectedCategory == 'Bachelor')
                                Positioned(
                                  right: 8,
                                  bottom: 8,
                                  child: Container(
                                    width: 20,
                                    height: 20,
                                    decoration: BoxDecoration(
                                        color: Color(0xFF00C897),
                                        shape: BoxShape.circle
                                    ),
                                    child: Icon(
                                      Icons.check,
                                      color: Colors.white,
                                    ),
                                  ),
                                )
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () => _selectAndNavigate('Sublet'),
                          child: Stack(
                            children: [
                              Container(
                                width: 115,
                                height: 133,
                                decoration: BoxDecoration(
                                    color: selectedCategory =='Sublet'
                                        ? Color(0xFFDCDCDC)
                                        : Color(0xFFF2F8FF),
                                    borderRadius: BorderRadius.circular(16),
                                    border: Border.all(
                                      color: selectedCategory=='Sublet'
                                          ? Color(0xFF00C897)
                                          : Color(0xFFE0E0E0),
                                      width: selectedCategory=='Sublet' ? 2 : 1,
                                    )
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image(image: AssetImage('assets/icons/Sublet.png'),
                                        height: 48,
                                        width: 48
                                    ),
                                    SizedBox(height: 5),
                                    Text(
                                      'Sublet',
                                      style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w600,
                                          color: Color(0xFF000000)
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              if(selectedCategory == 'Sublet')
                                Positioned(
                                  right: 8,
                                  bottom: 8,
                                  child: Container(
                                    width: 20,
                                    height: 20,
                                    decoration: BoxDecoration(
                                        color: Color(0xFF00C897),
                                        shape: BoxShape.circle
                                    ),
                                    child: Icon(
                                      Icons.check,
                                      color: Colors.white,
                                    ),
                                  ),
                                )
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 25),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () => _selectAndNavigate('Room'),
                          child: Stack(
                            children: [
                              Container(
                                width: 115,
                                height: 133,
                                decoration: BoxDecoration(
                                    color: selectedCategory =='Room'
                                        ? Color(0xFFDCDCDC)
                                        : Color(0xFFF2F8FF),
                                    borderRadius: BorderRadius.circular(16),
                                    border: Border.all(
                                      color: selectedCategory=='Room'
                                          ? Color(0xFF00C897)
                                          : Color(0xFFE0E0E0),
                                      width: selectedCategory=='Room' ? 2 : 1,
                                    )
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image(image: AssetImage('assets/icons/Room.png'),
                                        height: 48,
                                        width: 48
                                    ),
                                    SizedBox(height: 5),
                                    Text(
                                      'Room',
                                      style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w600,
                                          color: Color(0xFF000000)
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              if(selectedCategory == 'Room')
                                Positioned(
                                  right: 8,
                                  bottom: 8,
                                  child: Container(
                                    width: 20,
                                    height: 20,
                                    decoration: BoxDecoration(
                                        color: Color(0xFF00C897),
                                        shape: BoxShape.circle
                                    ),
                                    child: Icon(
                                      Icons.check,
                                      color: Colors.white,
                                    ),
                                  ),
                                )
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () => _selectAndNavigate('Bachelor'),
                          child: Stack(
                            children: [
                              Container(
                                width: 115,
                                height: 133,
                                decoration: BoxDecoration(
                                    color: selectedCategory =='Hotel'
                                        ? Color(0xFFDCDCDC)
                                        : Color(0xFFF2F8FF),
                                    borderRadius: BorderRadius.circular(16),
                                    border: Border.all(
                                      color: selectedCategory=='Hotel'
                                          ? Color(0xFF00C897)
                                          : Color(0xFFE0E0E0),
                                      width: selectedCategory=='Hotel' ? 2 : 1,
                                    )
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image(image: AssetImage('assets/icons/Hotel.png'),
                                        height: 48,
                                        width: 48
                                    ),
                                    SizedBox(height: 5),
                                    Text(
                                      'Hotel',
                                      style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w600,
                                          color: Color(0xFF000000)
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              if(selectedCategory == 'Hotel')
                                Positioned(
                                  right: 8,
                                  bottom: 8,
                                  child: Container(
                                    width: 20,
                                    height: 20,
                                    decoration: BoxDecoration(
                                        color: Color(0xFF00C897),
                                        shape: BoxShape.circle
                                    ),
                                    child: Icon(
                                      Icons.check,
                                      color: Colors.white,
                                    ),
                                  ),
                                )
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () => _selectAndNavigate('Mess'),
                          child: Stack(
                            children: [
                              Container(
                                width: 115,
                                height: 133,
                                decoration: BoxDecoration(
                                    color: selectedCategory =='Mess'
                                        ? Color(0xFFDCDCDC)
                                        : Color(0xFFF2F8FF),
                                    borderRadius: BorderRadius.circular(16),
                                    border: Border.all(
                                      color: selectedCategory=='Mess'
                                          ? Color(0xFF00C897)
                                          : Color(0xFFE0E0E0),
                                      width: selectedCategory=='Mess' ? 2 : 1,
                                    )
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image(image: AssetImage('assets/icons/Mess.png'),
                                        height: 48,
                                        width: 48
                                    ),
                                    SizedBox(height: 5),
                                    Text(
                                      'Mess',
                                      style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w600,
                                          color: Color(0xFF000000)
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              if(selectedCategory == 'Mess')
                                Positioned(
                                  right: 8,
                                  bottom: 8,
                                  child: Container(
                                    width: 20,
                                    height: 20,
                                    decoration: BoxDecoration(
                                        color: Color(0xFF00C897),
                                        shape: BoxShape.circle
                                    ),
                                    child: Icon(
                                      Icons.check,
                                      color: Colors.white,
                                    ),
                                  ),
                                )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          )
    );
  }
}
