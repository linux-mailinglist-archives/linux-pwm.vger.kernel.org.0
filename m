Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EDDE4C247A
	for <lists+linux-pwm@lfdr.de>; Mon, 30 Sep 2019 17:40:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731868AbfI3Pj5 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 30 Sep 2019 11:39:57 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:24426 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727326AbfI3Pj5 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 30 Sep 2019 11:39:57 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x8UFUk76017914;
        Mon, 30 Sep 2019 17:39:43 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=oqsc+1QmxySevnQ/cOpQpMNn/oNbv445DQVbjVNoArI=;
 b=f1MgDsNhuFHK8bCjXeH8DmXI/CufFHMbcnW9G7FHHrX2iG4T4YPR608/YWXZzC2AdxTb
 86URQUZFfI/A8K3AJp/ujzArs4wMkvHp+YSj0Pyy4gaBihMcGmJnVgiN54JH+BUpj5Z5
 7TLydY58qojHS//sun3gev4W1yP+1MhI81pnPW+BPoHpWWWhJQ7EXbDwkpPjUzf8shZG
 dY12HH3sgENVgTMEx6+OqqMeXS0QnLWg6JTNTQiuBMUTKb+TY0uKpA6ovdr33PeHdzwN
 Gh8bWygbIcsi9PeYvcztSL3OJCpKA0NR+wojkn+WQNWKq/i5az248bO5oJXsfCU/5bf/ BA== 
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
        by mx07-00178001.pphosted.com with ESMTP id 2v9w9vm0qc-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 30 Sep 2019 17:39:43 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 57A6F24;
        Mon, 30 Sep 2019 15:39:40 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas24.st.com [10.75.90.94])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 77EA12A45FA;
        Mon, 30 Sep 2019 17:39:39 +0200 (CEST)
Received: from SAFEX1HUBCAS22.st.com (10.75.90.92) by Safex1hubcas24.st.com
 (10.75.90.94) with Microsoft SMTP Server (TLS) id 14.3.439.0; Mon, 30 Sep
 2019 17:39:39 +0200
Received: from localhost (10.48.0.192) by Webmail-ga.st.com (10.75.90.48) with
 Microsoft SMTP Server (TLS) id 14.3.439.0; Mon, 30 Sep 2019 17:39:38 +0200
From:   Fabrice Gasnier <fabrice.gasnier@st.com>
To:     <thierry.reding@gmail.com>, <robh+dt@kernel.org>
CC:     <alexandre.torgue@st.com>, <mark.rutland@arm.com>,
        <mcoquelin.stm32@gmail.com>, <fabrice.gasnier@st.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
        <benjamin.gaignard@st.com>,
        <linux-stm32@st-md-mailman.stormreply.com>
Subject: [PATCH 0/2] Add PM support to STM32 Timer PWM
Date:   Mon, 30 Sep 2019 17:39:09 +0200
Message-ID: <1569857951-20007-1-git-send-email-fabrice.gasnier@st.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.48.0.192]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-09-30_09:2019-09-30,2019-09-30 signatures=0
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

This patch series adds power management support for STM32 Timer PWM:
- Document the pinctrl sleep state for STM32 Timer PWM
- STM32 Timer PWM driver

Fabrice Gasnier (2):
  dt-bindings: pwm-stm32: document pinctrl sleep state
  pwm: stm32: add power management support

 .../devicetree/bindings/pwm/pwm-stm32.txt          |  8 ++-
 drivers/pwm/pwm-stm32.c                            | 82 ++++++++++++++++------
 2 files changed, 67 insertions(+), 23 deletions(-)

-- 
2.7.4

