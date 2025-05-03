class JobPostModel {
  final String profileImg;
  final JobPost jobpost;
  final Company company;
  final List<Skill> skills;
  final List<Section> sections;
  final List<Question> questions;
  final String timeAgo;
  final bool applyStatus;

  JobPostModel({
    required this.profileImg,
    required this.jobpost,
    required this.company,
    required this.skills,
    required this.sections,
    required this.questions,
    required this.timeAgo,
    required this.applyStatus,
  });

  factory JobPostModel.fromJson(Map<String, dynamic> json) {
    return JobPostModel(
      profileImg: json['profile_img'],
      jobpost: JobPost.fromJson(json['jobpost']),
      company: Company.fromJson(json['company']),
      skills: List<Skill>.from(json['skills'].map((x) => Skill.fromJson(x))),
      sections: List<Section>.from(json['sections'].map((x) => Section.fromJson(x))),
      questions: List<Question>.from(json['questions'].map((x) => Question.fromJson(x))),
      timeAgo: json['time_ago'],
      applyStatus: json['applystatus'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'profile_img': profileImg,
      'jobpost': jobpost.toJson(),
      'company': company.toJson(),
      'skills': skills.map((x) => x.toJson()).toList(),
      'sections': sections.map((x) => x.toJson()).toList(),
      'questions': questions.map((x) => x.toJson()).toList(),
      'time_ago': timeAgo,
      'applystatus': applyStatus,
    };
  }
}

class JobPost {
  final int jobId;
  final String jobTitle;
  final String jobAbout;
  final String jobTime;
  final String jobType;
  final String jobCountry;
  final String jobCity;
  final int companyId;
  final String createdAt;

  JobPost({
    required this.jobId,
    required this.jobTitle,
    required this.jobAbout,
    required this.jobTime,
    required this.jobType,
    required this.jobCountry,
    required this.jobCity,
    required this.companyId,
    required this.createdAt,
  });

  factory JobPost.fromJson(Map<String, dynamic> json) {
    return JobPost(
      jobId: json['job_id'],
      jobTitle: json['job_title'],
      jobAbout: json['job_about'],
      jobTime: json['job_time'],
      jobType: json['job_type'],
      jobCountry: json['job_country'],
      jobCity: json['job_city'],
      companyId: json['company_id'],
      createdAt: json['created_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'job_id': jobId,
      'job_title': jobTitle,
      'job_about': jobAbout,
      'job_time': jobTime,
      'job_type': jobType,
      'job_country': jobCountry,
      'job_city': jobCity,
      'company_id': companyId,
      'created_at': createdAt,
    };
  }
}

class Company {
  final String companyName;
  final int userId;

  Company({
    required this.companyName,
    required this.userId,
  });

  factory Company.fromJson(Map<String, dynamic> json) {
    return Company(
      companyName: json['company_name'],
      userId: json['user_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'company_name': companyName,
      'user_id': userId,
    };
  }
}

class Skill {
  final int skillId;
  final String skill;

  Skill({
    required this.skillId,
    required this.skill,
  });

  factory Skill.fromJson(Map<String, dynamic> json) {
    return Skill(
      skillId: json['skill_id'],
      skill: json['skill'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'skill_id': skillId,
      'skill': skill,
    };
  }
}

class Section {
  final int sectionId;
  final String sectionName;
  final String sectionDescription;

  Section({
    required this.sectionId,
    required this.sectionName,
    required this.sectionDescription,
  });

  factory Section.fromJson(Map<String, dynamic> json) {
    return Section(
      sectionId: json['section_id'],
      sectionName: json['section_name'],
      sectionDescription: json['section_description'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'section_id': sectionId,
      'section_name': sectionName,
      'section_description': sectionDescription,
    };
  }
}

class Question {
  final int questionId;
  final String question;

  Question({
    required this.questionId,
    required this.question,
  });

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      questionId: json['question_id'],
      question: json['question'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'question_id': questionId,
      'question': question,
    };
  }
}
