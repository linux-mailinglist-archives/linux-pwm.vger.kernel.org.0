Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF87C7863F
	for <lists+linux-pwm@lfdr.de>; Mon, 29 Jul 2019 09:22:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726900AbfG2HWh (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 29 Jul 2019 03:22:37 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:39101 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725917AbfG2HWh (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 29 Jul 2019 03:22:37 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6T7LhjY024911;
        Mon, 29 Jul 2019 09:22:12 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=BrcI7CA5OtqOSVGd0MNreUQcr/fWMiNNKrFXwlcauwg=;
 b=HtsVBdFzeQGhEJOx7laE7SNZm50J5WstAiEevq/LZ+iQZW2lYEJQRyJ7banSr5LH7Tih
 l1UDVn1J6MArE0IwuGH9FNg8m0cVOKcsE+JPNFLRiSRkRi+etUFsh3aryLgPNweJmVoh
 sWjNxpxS76Vi386fd0NXzX6oua5xkmoyQHlZIHpsG9nxuLfLev6RffhuIxEXRRG1Gkr5
 UfWnVsNnb9/1FBdBz7ULimDF1HkHIS8HTIxJL+K/tE8JkX7Bkky32lTBmHYahH8rMMNs
 fg1QdsQntZpaATKUX/iNemClh5ygi1MdpW2DVyHDmlHefyZ8Lm+UJ3P0CvvZZZUg4kgR fQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2u0ccwanmu-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 29 Jul 2019 09:22:12 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 1ABFD38;
        Mon, 29 Jul 2019 07:22:10 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id A2D77569B;
        Mon, 29 Jul 2019 07:22:10 +0000 (GMT)
Received: from lmecxl0912.lme.st.com (10.75.127.51) by SFHDAG3NODE2.st.com
 (10.75.127.8) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Mon, 29 Jul
 2019 09:22:09 +0200
Subject: Re: [PATCH 0/5] Add missing pwm-cells to STM32 timers PWM
To:     Fabrice Gasnier <fabrice.gasnier@st.com>,
        <thierry.reding@gmail.com>, <robh+dt@kernel.org>
CC:     <mark.rutland@arm.com>, <linux@armlinux.org.uk>,
        <mcoquelin.stm32@gmail.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
        <benjamin.gaignard@st.com>,
        <linux-stm32@st-md-mailman.stormreply.com>
References: <1560937925-8990-1-git-send-email-fabrice.gasnier@st.com>
From:   Alexandre Torgue <alexandre.torgue@st.com>
Message-ID: <542bd9ed-a93f-fdcc-5dc9-ccaed8a50097@st.com>
Date:   Mon, 29 Jul 2019 09:22:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1560937925-8990-1-git-send-email-fabrice.gasnier@st.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.51]
X-ClientProxiedBy: SFHDAG6NODE1.st.com (10.75.127.16) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-29_04:,,
 signatures=0
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Fabrice

On 6/19/19 11:52 AM, Fabrice Gasnier wrote:
> This series adds missing generic 3-cells PWM to STM32 timers dt-bindings,
> PWM driver, and the relevant dtsi files for STM32F4, STM32F7 and STM32MP1.
> 
> Fabrice Gasnier (5):
>    dt-bindings: pwm-stm32: add #pwm-cells
>    pwm: stm32: use 3 cells ->of_xlate()
>    ARM: dts: stm32: add pwm cells to stm32mp157c
>    ARM: dts: stm32: add pwm cells to stm32f429
>    ARM: dts: stm32: add pwm cells to stm32f746
> 
>   Documentation/devicetree/bindings/pwm/pwm-stm32.txt |  3 +++
>   arch/arm/boot/dts/stm32f429.dtsi                    | 12 ++++++++++++
>   arch/arm/boot/dts/stm32f746.dtsi                    | 12 ++++++++++++
>   arch/arm/boot/dts/stm32mp157c.dtsi                  | 12 ++++++++++++
>   drivers/pwm/pwm-stm32.c                             |  2 ++
>   5 files changed, 41 insertions(+)
> 

DT patches applied on stm32-next.

regards
Alex
