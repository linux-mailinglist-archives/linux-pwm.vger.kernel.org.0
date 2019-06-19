Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 688344B580
	for <lists+linux-pwm@lfdr.de>; Wed, 19 Jun 2019 11:52:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727002AbfFSJwj (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 19 Jun 2019 05:52:39 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:57604 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726479AbfFSJwi (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 19 Jun 2019 05:52:38 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5J9l43Y004729;
        Wed, 19 Jun 2019 11:52:14 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=nty6ih6iIW5KM2QvYy/1B11xGsZE8DkrKWnNc/nyI6g=;
 b=oBzmJN2JkzWIsWm32xd5oVFIvuGHnSMLHytkTJpZ/MVxjXnWr5pLpieutjXJYRJ7iARO
 V6kHtLJIePQvjfRjFbPizBRVYa9j6OLQP12Z/t4tJBueeer4DFqWyDLmOqq2VlttP8j+
 4iQC+TSjXH8rFVdjvzSMOMLrHf7y+QxS9/J/nCJH4G3e66tpgYdHZWJcH9+PJ8TR3yD1
 ec0HnBjyh1W++pyUnauzGvgLyTQzwxcKuhRE/vvft8u3rqlj4c9z/hw0lvwf/H5igyV+
 uAOs71CXbF1DIsJZzLrmdc95WVlH9XG5nXEw2AHdQudPqpFNTXALrcnK1rJORk+5WzuI Hg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2t7812u73c-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 19 Jun 2019 11:52:14 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id BAE6F38;
        Wed, 19 Jun 2019 09:52:13 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag5node3.st.com [10.75.127.15])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 78AD524CC;
        Wed, 19 Jun 2019 09:52:13 +0000 (GMT)
Received: from localhost (10.75.127.44) by SFHDAG5NODE3.st.com (10.75.127.15)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 19 Jun 2019 11:52:13
 +0200
From:   Fabrice Gasnier <fabrice.gasnier@st.com>
To:     <thierry.reding@gmail.com>, <robh+dt@kernel.org>,
        <alexandre.torgue@st.com>
CC:     <mark.rutland@arm.com>, <linux@armlinux.org.uk>,
        <mcoquelin.stm32@gmail.com>, <fabrice.gasnier@st.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
        <benjamin.gaignard@st.com>,
        <linux-stm32@st-md-mailman.stormreply.com>
Subject: [PATCH 0/5] Add missing pwm-cells to STM32 timers PWM
Date:   Wed, 19 Jun 2019 11:52:00 +0200
Message-ID: <1560937925-8990-1-git-send-email-fabrice.gasnier@st.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG7NODE1.st.com (10.75.127.19) To SFHDAG5NODE3.st.com
 (10.75.127.15)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-19_05:,,
 signatures=0
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

This series adds missing generic 3-cells PWM to STM32 timers dt-bindings,
PWM driver, and the relevant dtsi files for STM32F4, STM32F7 and STM32MP1.

Fabrice Gasnier (5):
  dt-bindings: pwm-stm32: add #pwm-cells
  pwm: stm32: use 3 cells ->of_xlate()
  ARM: dts: stm32: add pwm cells to stm32mp157c
  ARM: dts: stm32: add pwm cells to stm32f429
  ARM: dts: stm32: add pwm cells to stm32f746

 Documentation/devicetree/bindings/pwm/pwm-stm32.txt |  3 +++
 arch/arm/boot/dts/stm32f429.dtsi                    | 12 ++++++++++++
 arch/arm/boot/dts/stm32f746.dtsi                    | 12 ++++++++++++
 arch/arm/boot/dts/stm32mp157c.dtsi                  | 12 ++++++++++++
 drivers/pwm/pwm-stm32.c                             |  2 ++
 5 files changed, 41 insertions(+)

-- 
2.7.4

