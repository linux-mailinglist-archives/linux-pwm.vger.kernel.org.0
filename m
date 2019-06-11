Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E597C41852
	for <lists+linux-pwm@lfdr.de>; Wed, 12 Jun 2019 00:42:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728493AbfFKWkr (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 11 Jun 2019 18:40:47 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:39978 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728264AbfFKWkq (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 11 Jun 2019 18:40:46 -0400
Received: by mail-it1-f193.google.com with SMTP id q14so7500592itc.5;
        Tue, 11 Jun 2019 15:40:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HI3rHUK26/S2B0LA3WlM09q3Q/jcQRPOrltE5Dys4vg=;
        b=Dm9ERfhKIYwMTkOatw40rA3Cw/gkTrsdoub8QQTIgQZrR+NcOMaqGrrUagRiHG5ClT
         IVIbBUNjelDB4ONk4R7S+ZTMvEqid5nSMTjTmEzBWoAAPD6WBM83iFGrRjx61x6yDdUo
         RQpa/8YR1rhJYBMXfb7XsNumP4SiHOyvEj1B+8Ue8OswbL0U+xGtsk604y7borgK7Ub7
         lx5P+NU+0R6yNWzU51z1//riCumr2uVnH+f6KFFB87tjC5Va8rMwTN2ccVNYiqhYLiIk
         yh3OvcFqieJSyuTJug1h266+TezZrydNnKwA5GIVTVW+SrPaxEHNQTLhvXQ3I5O9FExl
         L2og==
X-Gm-Message-State: APjAAAVobYvlcbX9XPzmWR9Uoq6/2CJNhXOCCKjUgSpf+IGYEemQyTwM
        IvleN2pb/fGhNPqL8Yy5xVj4VfQ=
X-Google-Smtp-Source: APXvYqyYN7ZbEDoYi00MhHLqHL7FwPdCa2uF9Kv/WyYmja0MIBn3v9bIz1f2IeqAvvSfdbDWHNDRAg==
X-Received: by 2002:a24:b303:: with SMTP id e3mr18466988itf.170.1560292845706;
        Tue, 11 Jun 2019 15:40:45 -0700 (PDT)
Received: from localhost (ip-174-149-252-64.englco.spcsdns.net. [174.149.252.64])
        by smtp.gmail.com with ESMTPSA id p10sm5553716iob.54.2019.06.11.15.40.44
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 11 Jun 2019 15:40:45 -0700 (PDT)
Date:   Tue, 11 Jun 2019 16:40:41 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jitao Shi <jitao.shi@mediatek.com>
Cc:     Pawel Moll <pawel.moll@arm.com>,
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
Message-ID: <20190611224041.GA407@bogus>
References: <20190608070230.55381-1-jitao.shi@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190608070230.55381-1-jitao.shi@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Sat, Jun 08, 2019 at 03:02:29PM +0800, Jitao Shi wrote:
> Add documentation for boe tv101wum-n16 panel.

Typo in the subject and checkpatch complains about trailing whitespace.

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
> +- reg: the virtual channel number of a DSI peripheral
> +- enable-gpios: a GPIO spec for the enable pin
> +- pp1800-supply: core voltage supply
> +- avdd-supply: 
> +- avee-supply: 
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

Fix this.
