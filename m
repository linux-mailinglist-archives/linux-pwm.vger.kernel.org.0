Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F60E5631B
	for <lists+linux-pwm@lfdr.de>; Wed, 26 Jun 2019 09:20:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726894AbfFZHUy (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 26 Jun 2019 03:20:54 -0400
Received: from asavdk4.altibox.net ([109.247.116.15]:57704 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725930AbfFZHUy (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 26 Jun 2019 03:20:54 -0400
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk4.altibox.net (Postfix) with ESMTPS id 6E28580314;
        Wed, 26 Jun 2019 09:20:49 +0200 (CEST)
Date:   Wed, 26 Jun 2019 09:20:48 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Jitao Shi <jitao.shi@mediatek.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        linux-pwm@vger.kernel.org, David Airlie <airlied@linux.ie>,
        Matthias Brugger <matthias.bgg@gmail.com>, stonea168@163.com,
        dri-devel@lists.freedesktop.org,
        Andy Yan <andy.yan@rock-chips.com>,
        Ajay Kumar <ajaykumar.rs@samsung.com>,
        Vincent Palatin <vpalatin@chromium.org>,
        cawa.cheng@mediatek.com,
        Russell King <rmk+kernel@arm.linux.org.uk>,
        Thierry Reding <treding@nvidia.com>,
        devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org,
        yingjoe.chen@mediatek.com, eddie.huang@mediatek.com,
        linux-arm-kernel@lists.infradead.org,
        Rahul Sharma <rahul.sharma@samsung.com>,
        srv_heupstream@mediatek.com, linux-kernel@vger.kernel.org,
        Sascha Hauer <kernel@pengutronix.de>,
        Sean Paul <seanpaul@chromium.org>
Subject: Re: [v3 1/4] dt-bindngs: display: panel: Add BOE tv101wum-n16 panel
 bindings
Message-ID: <20190626072048.GB14541@ravnborg.org>
References: <20190626025400.109567-1-jitao.shi@mediatek.com>
 <20190626025400.109567-2-jitao.shi@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190626025400.109567-2-jitao.shi@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=VcLZwmh9 c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=mpaa-ttXAAAA:8
        a=7gkXJVJtAAAA:8 a=e5mUnYsNAAAA:8 a=GOHkJZeNjhEJBjOU3QsA:9
        a=CjuIK1q_8ugA:10 a=6heAxKwa5pAsJatQ0mat:22 a=E9Po1WZjFZOl8hwRPBS3:22
        a=Vxmtnl_E_bksehYqCbjh:22
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Wed, Jun 26, 2019 at 10:53:57AM +0800, Jitao Shi wrote:
> Add documentation for boe tv101wum-n16 panel.
> 
> Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
> ---
>  .../display/panel/boe,tv101wum-nl6.txt        | 34 +++++++++++++++++++
>  1 file changed, 34 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/panel/boe,tv101wum-nl6.txt
> 
> diff --git a/Documentation/devicetree/bindings/display/panel/boe,tv101wum-nl6.txt b/Documentation/devicetree/bindings/display/panel/boe,tv101wum-nl6.txt
> new file mode 100644
> index 000000000000..bd44af636390
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/panel/boe,tv101wum-nl6.txt
> @@ -0,0 +1,34 @@
> +Boe Corporation 10.1" WUXGA TFT LCD panel
> +
> +Required properties:
> +- compatible: should be "boe,tv101wum-nl6"
> +- reg: the virtual channel number of a DSI peripheral
> +- enable-gpios: a GPIO spec for the enable pin
> +- pp1800-supply: core voltage supply
> +- avdd-supply: phandle of the regulator that provides positive voltage
> +- avee-supply: phandle of the regulator that provides negative voltage
> +- backlight: phandle of the backlight device attached to the panel
> +
> +The device node can contain one 'port' child node with one child
> +'endpoint' node, according to the bindings defined in
> +media/video-interfaces.txt. This node should describe panel's video bus.
> +
> +Example:
> +&dsi {
> +	...
> +	panel@0 {
> +		compatible = "boe,tv101wum-nl6";
> +		reg = <0>;
> +		enable-gpios = <&pio 45 0>;
> +		avdd-supply = <&ppvarn_lcd>;
> +		avee-supply = <&ppvarp_lcd>;
> +		pp1800-supply = <&pp1800_lcd>;
> +		backlight = <&backlight_lcd0>;
> +		status = "okay";
> +		port {
> +			panel_in: endpoint {
> +				remote-endpoint = <&dsi_out>;
> +			};
> +		};
> +	};
> +};
> -- 
> 2.21.0
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
