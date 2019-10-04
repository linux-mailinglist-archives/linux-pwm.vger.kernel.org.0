Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 12FB9CBAE3
	for <lists+linux-pwm@lfdr.de>; Fri,  4 Oct 2019 14:54:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387719AbfJDMyZ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 4 Oct 2019 08:54:25 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:19942 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387573AbfJDMyZ (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 4 Oct 2019 08:54:25 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x94CpHkc007845;
        Fri, 4 Oct 2019 14:54:10 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=Gq4se5jZ9JpjIAQHXXEIaPHCYbZ6Lt/x+2ijv9uVcpE=;
 b=BBRNBdO3RHD/vo/BNcvJK5qTWDP+S3vU+f9VVi0z5PR9vnJyoMgYVjqiI+Zqihban3BU
 7QD+MDRKxmg52UzMB3aAp51uRel9mrQS9uvL2/OmPsbuJCCde26h7Ga7WepFxSEATEHQ
 0wAt/ZS4ml3mqYGBDIBLWNpcUzKjFCljkjhYRoA/DQ5RVzNbno5lyUkqw70Vzynauh6w
 ilrzrVU1HkFXves5723o2mEkBbVJnzvsw/vzM8tk9tLCIfD5/LipBi+XVBo9PKZhhmwx
 cfbRShTDsGsGxpbHjSWj1e/dEEf/kdcTWzf+muJ3jTNIX0vdQ+D2z9qwotFOQqLw2kAF CQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2vcem3fwgc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 04 Oct 2019 14:54:10 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 39DD6100034;
        Fri,  4 Oct 2019 14:54:10 +0200 (CEST)
Received: from Webmail-eu.st.com (Safex1hubcas24.st.com [10.75.90.94])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 03C4E2BFDEF;
        Fri,  4 Oct 2019 14:54:10 +0200 (CEST)
Received: from SAFEX1HUBCAS22.st.com (10.75.90.92) by Safex1hubcas24.st.com
 (10.75.90.94) with Microsoft SMTP Server (TLS) id 14.3.439.0; Fri, 4 Oct 2019
 14:54:09 +0200
Received: from localhost (10.48.0.192) by Webmail-ga.st.com (10.75.90.48) with
 Microsoft SMTP Server (TLS) id 14.3.439.0; Fri, 4 Oct 2019 14:54:09 +0200
From:   Fabrice Gasnier <fabrice.gasnier@st.com>
To:     <thierry.reding@gmail.com>, <robh+dt@kernel.org>,
        <u.kleine-koenig@pengutronix.de>
CC:     <alexandre.torgue@st.com>, <mark.rutland@arm.com>,
        <mcoquelin.stm32@gmail.com>, <fabrice.gasnier@st.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
        <benjamin.gaignard@st.com>,
        <linux-stm32@st-md-mailman.stormreply.com>
Subject: [PATCH v2 0/3] Add PM support to STM32 Timer PWM
Date:   Fri, 4 Oct 2019 14:53:50 +0200
Message-ID: <1570193633-6600-1-git-send-email-fabrice.gasnier@st.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.48.0.192]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-04_06:2019-10-03,2019-10-04 signatures=0
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

This patch series adds power management support for STM32 Timer PWM:
- Document the pinctrl sleep state for STM32 Timer PWM
- STM32 Timer PWM driver

---
Changes in v2:
Follow Uwe suggestions/remarks:
- Add a precursor patch to ease reviewing
- Use registers read instead of pwm_get_state
- Add a comment to mention registers content may be lost in low power mode

Fabrice Gasnier (3):
  dt-bindings: pwm-stm32: document pinctrl sleep state
  pwm: stm32: split breakinput apply routine to ease PM support
  pwm: stm32: add power management support

 .../devicetree/bindings/pwm/pwm-stm32.txt          |  8 +-
 drivers/pwm/pwm-stm32.c                            | 86 +++++++++++++++++-----
 2 files changed, 71 insertions(+), 23 deletions(-)

-- 
2.7.4

