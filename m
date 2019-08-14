Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DA2418D285
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Aug 2019 13:52:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726522AbfHNLwa (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 14 Aug 2019 07:52:30 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:32990 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726230AbfHNLwa (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 14 Aug 2019 07:52:30 -0400
X-UUID: a4df54e80d774f549f332572e73bbba6-20190814
X-UUID: a4df54e80d774f549f332572e73bbba6-20190814
Received: from mtkmrs01.mediatek.inc [(172.21.131.159)] by mailgw01.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0707 with TLS)
        with ESMTP id 1127642859; Wed, 14 Aug 2019 19:52:20 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs05n2.mediatek.inc (172.21.101.140) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 14 Aug 2019 19:52:24 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 14 Aug 2019 19:52:23 +0800
Message-ID: <1565783543.7006.8.camel@mtkswgap22>
Subject: Re: [PATCH v2 9/10] dt-bindings: pwm: update bindings for MT7628 SoC
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Sam Shih <sam.shih@mediatek.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        John Crispin <john@phrozen.org>, <linux-pwm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>
Date:   Wed, 14 Aug 2019 19:52:23 +0800
In-Reply-To: <1565779497-23621-2-git-send-email-sam.shih@mediatek.com>
References: <621e49c01b943edb6ddac9182f34719eb0727f01.1548313019.git.ryder.lee@mediatek.com>
         <1565779497-23621-2-git-send-email-sam.shih@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Wed, 2019-08-14 at 18:43 +0800, Sam Shih wrote:
> From: sam shih <sam.shih@mediatek.com>
> 
> This updates bindings for MT7628 pwm controller.
> 
> Signed-off-by: Sam Shih <sam.shih@mediatek.com>
> ---
>  .../devicetree/bindings/pwm/pwm-mediatek.txt       | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pwm/pwm-mediatek.txt b/Documentation/devicetree/bindings/pwm/pwm-mediatek.txt
> index c7bd5633d1eb..9d2d893a07ff 100644
> --- a/Documentation/devicetree/bindings/pwm/pwm-mediatek.txt
> +++ b/Documentation/devicetree/bindings/pwm/pwm-mediatek.txt
> @@ -21,6 +21,8 @@ Required properties:
>   - pinctrl-0: One property must exist for each entry in pinctrl-names.
>     See pinctrl/pinctrl-bindings.txt for details of the property values.
>   - num-pwms: the number of PWM channels.
> + - clock-frequency: fix clock frequency, this is an optional property, only use in MT7628 SoC
> +                    for period calculation. This SoC has no complex clock tree.

Optional properties:

- clock-frequency: ...

>  Example:
>  	pwm0: pwm@11006000 {
> @@ -40,3 +42,13 @@ Example:
>  		pinctrl-0 = <&pwm0_pins>;
>  		num-pwms = <5>;
>  	};

Add a blank here

> +MT7628 Example:
> +	pwm: pwm@5000 {
> +		compatible = "mediatek,mt7628-pwm";
> +		reg = <0x5000 0x1000>;
> +		#pwm-cells = <2>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pwm0_pins>, <&pwm1_pins>;
> +		num-pwms = <4>;
> +		clock-frequency = <100000>;
> +	};


