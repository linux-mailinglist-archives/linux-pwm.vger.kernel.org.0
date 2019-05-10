Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 593F11992F
	for <lists+linux-pwm@lfdr.de>; Fri, 10 May 2019 09:51:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726935AbfEJHvW (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 10 May 2019 03:51:22 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:57542 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726899AbfEJHvW (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 10 May 2019 03:51:22 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4A7ke2e019336;
        Fri, 10 May 2019 09:51:04 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=nmDxg4+93XGhQH+CBc6pkLSbg19CIe1swFbFgCL8ynY=;
 b=uR/72ikBnHLXDX5yi8jl/nbg4R6bAWIlVXcz+WyWuipKJP7UA4+VROg3MFgElPvXKUu+
 PrAexkTBVIP4hZvUSn3QFTiBL/0r8aRlUL33o9THxXKlkhyz5LuG668SvRR2d77uRgYR
 M/rENVvB5J8brAwKB4ZCsUnECND3xm58KDJtaUdq4jzUIj+R90IbaWrTd51J6ZryrrdQ
 OEDsDGHUo3K8vAu7mCrb8bwT1NIpnrAZyXoj7ylz1ceOibnGzdXqbSCOlkxgiaGKw7Hp
 G1CYGHSnbQ1RR4cAl9bndfPzGH7buA5hNwhCCSQAnJ/wXMwyg6CBKYzauGASOmzG6XEN LQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2scdjp7fum-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 10 May 2019 09:51:04 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 9800A3D;
        Fri, 10 May 2019 07:51:03 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag5node3.st.com [10.75.127.15])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 10EFC15CE;
        Fri, 10 May 2019 07:51:02 +0000 (GMT)
Received: from [10.48.0.167] (10.75.127.44) by SFHDAG5NODE3.st.com
 (10.75.127.15) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Fri, 10 May
 2019 09:51:02 +0200
Subject: Re: [RESEND PATCH v5 0/3] Add PM support to STM32 LP Timer drivers
To:     <thierry.reding@gmail.com>
CC:     <robh+dt@kernel.org>, <u.kleine-koenig@pengutronix.de>,
        <tduszyns@gmail.com>, <mark.rutland@arm.com>,
        <alexandre.torgue@st.com>, <mcoquelin.stm32@gmail.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        Loic PALLARDY <loic.pallardy@st.com>,
        Mark Brown <broonie@kernel.org>
References: <1555580267-29299-1-git-send-email-fabrice.gasnier@st.com>
From:   Fabrice Gasnier <fabrice.gasnier@st.com>
Message-ID: <45e934af-d677-d7d4-09ea-3ed01872dab6@st.com>
Date:   Fri, 10 May 2019 09:51:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1555580267-29299-1-git-send-email-fabrice.gasnier@st.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG1NODE1.st.com (10.75.127.1) To SFHDAG5NODE3.st.com
 (10.75.127.15)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-09_02:,,
 signatures=0
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On 4/18/19 11:37 AM, Fabrice Gasnier wrote:
> This patch series adds power management support for STM32 LP Timer:
> - PWM driver
> - Document the pinctrl states for sleep mode
> 
> It also adds device link between the PWM consumer and the PWM provider.
> This allows proper sequencing for suspend/resume (e.g. user will likely
> do a pwm_disable() before the PWM provider suspend executes), see [1].
> 
> [1] https://lkml.org/lkml/2019/2/5/770
> 

Hi Thierry,

Please let me know if you have some more comments on this series. It's
been under review since quite some time now.

Thanks in advance,
Best Regards,
Fabrice

> ---
> resend v5:
> - update collected acks
> 
> Changes in v5:
> - improve a warning message, fix a style issue.
> 
> Changes in v4:
> - improve error handling when adding the PWM consumer device link.
> 
> Changes in v3:
> - Move the device_link_add() call to of_pwm_get() as discussed with Uwe.
> 
> Changes in v2:
> - Don't disable PWM channel in PWM provider: rather refuse to suspend
>   and report an error as suggested by Uwe and Thierry.
> - Add patch 3/3 to propose device link addition.
> - No updates for STM32 LP Timer IIO driver. Patches can be send separately.
> 
> Fabrice Gasnier (3):
>   dt-bindings: pwm-stm32-lp: document pinctrl sleep state
>   pwm: stm32-lp: Add power management support
>   pwm: core: add consumer device link
> 
>  .../devicetree/bindings/pwm/pwm-stm32-lp.txt       |  9 ++--
>  drivers/pwm/core.c                                 | 50 ++++++++++++++++++++--
>  drivers/pwm/pwm-stm32-lp.c                         | 25 +++++++++++
>  include/linux/pwm.h                                |  6 ++-
>  4 files changed, 82 insertions(+), 8 deletions(-)
> 
