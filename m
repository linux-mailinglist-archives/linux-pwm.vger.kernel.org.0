Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A924556315
	for <lists+linux-pwm@lfdr.de>; Wed, 26 Jun 2019 09:20:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726416AbfFZHUa (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 26 Jun 2019 03:20:30 -0400
Received: from asavdk4.altibox.net ([109.247.116.15]:57620 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725876AbfFZHUa (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 26 Jun 2019 03:20:30 -0400
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk4.altibox.net (Postfix) with ESMTPS id E83478032F;
        Wed, 26 Jun 2019 09:20:22 +0200 (CEST)
Date:   Wed, 26 Jun 2019 09:20:21 +0200
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
Subject: Re: [v3 2/4] drm/panel: support for BOE tv101wum-nl6 wuxga dsi video
 mode panel
Message-ID: <20190626072021.GA14541@ravnborg.org>
References: <20190626025400.109567-1-jitao.shi@mediatek.com>
 <20190626025400.109567-3-jitao.shi@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190626025400.109567-3-jitao.shi@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=VcLZwmh9 c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=7gkXJVJtAAAA:8
        a=9UlFsKL00uGSb65IiHYA:9 a=CjuIK1q_8ugA:10 a=E9Po1WZjFZOl8hwRPBS3:22
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Jitao.

Driver looks good, one detail.

> +
> +struct panel_desc {
> +	const struct drm_display_mode *modes;
> +	unsigned int bpc;
> +
> +	/**
> +	 * @width: width (in millimeters) of the panel's active display area
> +	 * @height: height (in millimeters) of the panel's active display area
> +	 */
> +	struct {
> +		unsigned int width;
> +		unsigned int height;
> +	} size;
Maybe name these width_mm and height_mm.
Then they have the same name as where they are copied to,
and it is explicit documented that it is in mm.

The extra indirection with a struct is not needed in display_mode,
maybe drop it here too?
> +
> +	unsigned long mode_flags;
> +	enum mipi_dsi_pixel_format format;
> +	const struct panel_init_cmd *init_cmds;
> +	unsigned int lanes;
> +};
> +
...
> +static int boe_panel_unprepare(struct drm_panel *panel)
> +{
> +	struct boe_panel *boe = to_boe_panel(panel);
> +	int ret;
> +
> +	if (!boe->prepared)
> +		return 0;
> +
> +	ret = boe_panel_off(boe);
> +	if (ret < 0) {
> +		dev_err(panel->dev, "failed to set panel off: %d\n", ret);
> +		return ret;
> +	}
> +
> +	msleep(150);
> +	if (boe->enable_gpio)
> +		gpiod_set_value(boe->enable_gpio, 0);
Everywhere boe->enable_gpio is used it is checked like above.
Bot boe->enable_gpio in a mandatory property so it must be present.
The driver error out in probe if not present, so this check seems
redundandt?

Everything else looks really good.

With the above fixed / considered:
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>

	Sam
