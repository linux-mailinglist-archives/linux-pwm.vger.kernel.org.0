Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 44A3E1389DE
	for <lists+linux-pwm@lfdr.de>; Mon, 13 Jan 2020 04:43:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387417AbgAMDn5 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 12 Jan 2020 22:43:57 -0500
Received: from mail02.vodafone.es ([217.130.24.81]:46508 "EHLO
        mail02.vodafone.es" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387415AbgAMDn5 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 12 Jan 2020 22:43:57 -0500
IronPort-SDR: VYdwgyOk8E84b9IR1/gPJWQTO1mxQ7L9r4evwxpKQsVo7cWl/WVLZSwl2ZeDUrdqJq+zFS00bP
 bfiegvIruqnw==
IronPort-PHdr: =?us-ascii?q?9a23=3A/0r/bxcdzUeKgEeHAOWkmZLclGMj4u6mDksu8p?=
 =?us-ascii?q?Mizoh2WeGdxcSyYx7h7PlgxGXEQZ/co6odzbaP6Oa6Bz1Lv83JmUtBWaQEbw?=
 =?us-ascii?q?UCh8QSkl5oK+++Imq/EsTXaTcnFt9JTl5v8iLzG0FUHMHjew+a+SXqvnYdFR?=
 =?us-ascii?q?rlKAV6OPn+FJLMgMSrzeCy/IDYbxlViDanbr5+MRu7oR/PusQXhYZuJac8xx?=
 =?us-ascii?q?XUqXZUZupawn9lK0iOlBjm/Mew+5Bj8yVUu/0/8sNLTLv3caclQ7FGFToqK2?=
 =?us-ascii?q?866tHluhnFVguP+2ATUn4KnRpSAgjK9w/1U5HsuSbnrOV92S2aPcrrTbAoXD?=
 =?us-ascii?q?mp8qlmRAP0hCoBKjU19mbbhNFsg61BpRKgpwVzzpDTYIGPLPp+ebndcskGRW?=
 =?us-ascii?q?VfR8peSSpBDpqgYosTE+oOJ/pXr4njqFsLsxS+AxWsCPrxxT9On3P42qo60+?=
 =?us-ascii?q?I/HgDGxQAvAdQOu2nQoNj7KKseTeW5wa/VxjvBcvxWwy/w5obIfBA7v/+CXq?=
 =?us-ascii?q?9+fsXNxkcgDA7FkledppD5Mz+JyugBrW6W5PdgW+K1jG4nrhl8rCKxyccwlI?=
 =?us-ascii?q?bJnJ8exVDD9SV/z4Y+ONq1SFZlbt64DpRQrS+bN4xwQsMtWGxouD06xaYatp?=
 =?us-ascii?q?KhYCcKz5EnywTfa/yEaoWF5A/oWuWJITpgmn5pZbCyiwyv/UWu1uHwTNe43V?=
 =?us-ascii?q?lQoidLktTBsG0G2QbJ5cidUPR9+1+s2TOI1w/O9O5JOVs0la/HK545xb4wi4?=
 =?us-ascii?q?YTvVzDHiDonEX2i7ebdkA+9eip7+TneKvpppuAO4J7kA3+LKMuldGlDuQ2NQ?=
 =?us-ascii?q?gOWXaU9f6i27345UH5QbNKgeMqkqTBrpzWOMYWqrSkDwJbzoov8QizAji83N?=
 =?us-ascii?q?kWnXQLNFdFdwiGj4jtNVHOOvf4DfKnjlS0jjhr2+7JPqfvA5XKKHjDn6zsfb?=
 =?us-ascii?q?Zm60FH1AU/18xQ55VRCr0bIPLzWVf9tMbEAR8hLwy03+HnBc151oMfX2KPH6?=
 =?us-ascii?q?CYPLrKsV6G4+IiOPeMZIALtzbnMfQl5ODhjWU/mVADeamlx5wXaGq3HqcuH0?=
 =?us-ascii?q?LMZXvqn8dECXgPlhQxQfasi1CYVzNXIXGoUPEG6yk/Gb6hWL/OWo23yIOG2i?=
 =?us-ascii?q?jzSoVbem1cFVeKHnfrd56OUN8DbSuTJolqlTlSBpa7TIp07RyyuRWy9L1hIa?=
 =?us-ascii?q?KA4iAEuIj80956z+3Inxp0/jtxScSehTLeB1pol38FEmZllJt0plZwnwzbia?=
 =?us-ascii?q?U=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2GUIwDe5htemCMYgtlNGBoBAQEBAQE?=
 =?us-ascii?q?BAQEDAQEBAREBAQECAgEBAQGBewIBGAEBgS6BTVIgEpNQgU0fg0OLY4EAgx4?=
 =?us-ascii?q?VhggTDIFbDQEBAQEBNQIBAYRATgEXgQ8kOgQNAgMNAQEFAQEBAQEFBAEBAhA?=
 =?us-ascii?q?BAQEBAQYNCwYphUqCHQweAQQBAQEBAwMDAQEMAYNdBxkPOUpMAQ4BU4MEgks?=
 =?us-ascii?q?BATOcdAGNBA0NAoUdgjwECoEJgRojgTYBjBgagUE/gSMhgisIAYIBgn8BEgF?=
 =?us-ascii?q?sgkiCWQSNQhIhgQeIKZgXgkEEdolMjAKCNwEPiAGEMQMQgkUPgQmIA4ROgX2?=
 =?us-ascii?q?jN1eBDA16cTMagiYagSBPGA2IG44tQIEWEAJPiS6CMgEB?=
X-IPAS-Result: =?us-ascii?q?A2GUIwDe5htemCMYgtlNGBoBAQEBAQEBAQEDAQEBAREBA?=
 =?us-ascii?q?QECAgEBAQGBewIBGAEBgS6BTVIgEpNQgU0fg0OLY4EAgx4VhggTDIFbDQEBA?=
 =?us-ascii?q?QEBNQIBAYRATgEXgQ8kOgQNAgMNAQEFAQEBAQEFBAEBAhABAQEBAQYNCwYph?=
 =?us-ascii?q?UqCHQweAQQBAQEBAwMDAQEMAYNdBxkPOUpMAQ4BU4MEgksBATOcdAGNBA0NA?=
 =?us-ascii?q?oUdgjwECoEJgRojgTYBjBgagUE/gSMhgisIAYIBgn8BEgFsgkiCWQSNQhIhg?=
 =?us-ascii?q?QeIKZgXgkEEdolMjAKCNwEPiAGEMQMQgkUPgQmIA4ROgX2jN1eBDA16cTMag?=
 =?us-ascii?q?iYagSBPGA2IG44tQIEWEAJPiS6CMgEB?=
X-IronPort-AV: E=Sophos;i="5.69,427,1571695200"; 
   d="scan'208";a="323735105"
Received: from mailrel04.vodafone.es ([217.130.24.35])
  by mail02.vodafone.es with ESMTP; 13 Jan 2020 04:43:55 +0100
Received: (qmail 24487 invoked from network); 12 Jan 2020 05:00:21 -0000
Received: from unknown (HELO 192.168.1.3) (quesosbelda@[217.217.179.17])
          (envelope-sender <peterwong@hsbc.com.hk>)
          by mailrel04.vodafone.es (qmail-ldap-1.03) with SMTP
          for <linux-pwm@vger.kernel.org>; 12 Jan 2020 05:00:21 -0000
Date:   Sun, 12 Jan 2020 06:00:20 +0100 (CET)
From:   Peter Wong <peterwong@hsbc.com.hk>
Reply-To: Peter Wong <peterwonghkhsbc@gmail.com>
To:     linux-pwm@vger.kernel.org
Message-ID: <7424959.460816.1578805221500.JavaMail.cash@217.130.24.55>
Subject: Investment opportunity
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Greetings,
Please read the attached investment proposal and reply for more details.
Are you interested in loan?
Sincerely: Peter Wong




----------------------------------------------------
This email was sent by the shareware version of Postman Professional.

