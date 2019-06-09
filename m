Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 644AB3A4C9
	for <lists+linux-pwm@lfdr.de>; Sun,  9 Jun 2019 12:33:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728374AbfFIKcv (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 9 Jun 2019 06:32:51 -0400
Received: from asavdk3.altibox.net ([109.247.116.14]:57814 "EHLO
        asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728168AbfFIKcv (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 9 Jun 2019 06:32:51 -0400
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk3.altibox.net (Postfix) with ESMTPS id C6F642002D;
        Sun,  9 Jun 2019 12:32:42 +0200 (CEST)
Date:   Sun, 9 Jun 2019 12:32:41 +0200
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
Subject: Re: [1/2] dt-bindngs: display: panel: Add BOE tv101wum-nl6 panel
 bindings
Message-ID: <20190609103241.GA28935@ravnborg.org>
References: <20190608070230.55381-1-jitao.shi@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190608070230.55381-1-jitao.shi@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=dqr19Wo4 c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=mpaa-ttXAAAA:8
        a=GOHkJZeNjhEJBjOU3QsA:9 a=zQRrZ5hHoVty9KUv:21 a=G8XELezRatH2Uwd4:21
        a=CjuIK1q_8ugA:10 a=6heAxKwa5pAsJatQ0mat:22
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Jitao

Always good to see more panels added.

On Sat, Jun 08, 2019 at 03:02:29PM +0800, Jitao Shi wrote:
> Add documentation for boe tv101wum-n16 panel.

The changelog says tv101wum-n16 but the compatible says tv101wum-nl6.
Please pick the right one and be consistent. (number one '1' versus
character 'l')

> 
> Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
> ---
>  .../display/panel/boe,tv101wum-nl6.txt        | 34 +++++++++++++++++++
>  1 file changed, 34 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/panel/boe,tv101wum-nl6.txt
> 
> diff --git a/Documentation/devicetree/bindings/display/panel/boe,tv101wum-nl6.txt b/Documentation/devicetree/bindings/display/panel/boe,tv101wum-nl6.txt
> new file mode 100644
> index 000000000000..2a84735d742d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/panel/boe,tv101wum-nl6.txt
> @@ -0,0 +1,34 @@
> +Boe Corporation 10.1" WUXGA TFT LCD panel
> +
> +Required properties:
> +- compatible: should be "boe,tv101wum"
The example uses "boe,tv101wum-nl6", which matches the filename.
Please fix so it is the same all over.

> +- reg: the virtual channel number of a DSI peripheral
> +- enable-gpios: a GPIO spec for the enable pin
> +- pp1800-supply: core voltage supply
> +- avdd-supply: 
> +- avee-supply: 
Missing descriptions - please add.
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
> \ No newline at end of file
Please add newline.

	Sam
