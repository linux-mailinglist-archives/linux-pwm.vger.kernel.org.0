Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7D6F598D1E
	for <lists+linux-pwm@lfdr.de>; Thu, 22 Aug 2019 10:13:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732128AbfHVIM2 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 22 Aug 2019 04:12:28 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:4560 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731361AbfHVIM1 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 22 Aug 2019 04:12:27 -0400
X-UUID: 148adf214d5e41aeb732a3567d7658e1-20190822
X-UUID: 148adf214d5e41aeb732a3567d7658e1-20190822
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <yingjoe.chen@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0707 with TLS)
        with ESMTP id 505389812; Thu, 22 Aug 2019 16:12:21 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 22 Aug 2019 16:12:15 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 22 Aug 2019 16:12:15 +0800
Message-ID: <1566461540.16302.4.camel@mtksdaap41>
Subject: Re: [PATCH v5 08/13] dt-bindings: pwm: update bindings for MT7628
 SoC
From:   Yingjoe Chen <yingjoe.chen@mediatek.com>
To:     Sam Shih <sam.shih@mediatek.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        <linux-pwm@vger.kernel.org>, Ryder Lee <ryder.lee@mediatek.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        "John Crispin" <john@phrozen.org>
Date:   Thu, 22 Aug 2019 16:12:20 +0800
In-Reply-To: <1566457123-20791-9-git-send-email-sam.shih@mediatek.com>
References: <1566457123-20791-1-git-send-email-sam.shih@mediatek.com>
         <1566457123-20791-9-git-send-email-sam.shih@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-SNTS-SMTP: 3BD61D47ACABA7964220A1B0223F5209B3AA948622B67FF3DAA9B078EE5B90732000:8
X-MTK:  N
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Thu, 2019-08-22 at 14:58 +0800, Sam Shih wrote:
> This updates bindings for MT7628 pwm controller.
> 
> Signed-off-by: Sam Shih <sam.shih@mediatek.com>
> ---
>  Documentation/devicetree/bindings/pwm/pwm-mediatek.txt | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pwm/pwm-mediatek.txt b/Documentation/devicetree/bindings/pwm/pwm-mediatek.txt
> index ea95b490a913..93980e3da261 100644
> --- a/Documentation/devicetree/bindings/pwm/pwm-mediatek.txt
> +++ b/Documentation/devicetree/bindings/pwm/pwm-mediatek.txt
> @@ -21,6 +21,10 @@ Required properties:
>     See pinctrl/pinctrl-bindings.txt for details of the property values.
>   - num-pwms: the number of PWM channels.
> +
> + Optional properties:
> + - clock-frequency: fix clock frequency, this is only used in MT7628 SoC
> +                    for period calculation. This SoC has no complex clock tree.

I'm sorry if this has been discussed before. 

Would it be simpler if you just provide a fixed-clock as clock in device
tree? This way you don't need this optional properties and don't need to
special handle it in driver code. 

After all, the hw is still connected to a simple clock tree.

Joe.C


