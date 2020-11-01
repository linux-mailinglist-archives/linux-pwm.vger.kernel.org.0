Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27EC82A1F20
	for <lists+linux-pwm@lfdr.de>; Sun,  1 Nov 2020 16:34:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726953AbgKAPd6 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 1 Nov 2020 10:33:58 -0500
Received: from gloria.sntech.de ([185.11.138.130]:47662 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726637AbgKAPd6 (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Sun, 1 Nov 2020 10:33:58 -0500
Received: from p57b773f8.dip0.t-ipconnect.de ([87.183.115.248] helo=phil.fritz.box)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1kZFMY-0003rS-Uf; Sun, 01 Nov 2020 16:33:47 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     Alexandru Stan <amstan@chromium.org>,
        Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Andy Gross <agross@kernel.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     Heiko Stuebner <heiko@sntech.de>, linux-pwm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Matthias Kaehlcke <mka@chromium.org>,
        linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 0/3] PWM backlight interpolation adjustments
Date:   Sun,  1 Nov 2020 16:33:41 +0100
Message-Id: <160424139256.1224767.4744407641354846090.b4-ty@sntech.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201022050445.930403-1-amstan@chromium.org>
References: <20201022050445.930403-1-amstan@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Wed, 21 Oct 2020 22:04:42 -0700, Alexandru Stan wrote:
> I was trying to adjust the brightness-levels for the trogdor boards:
> https://chromium-review.googlesource.com/c/chromiumos/third_party/kernel/+/2291209
> Like on a lot of panels, trogdor's low end needs to be cropped,
> and now that we have the interpolation stuff I wanted to make use of it
> and bake in even the curve that's customary to have on chromebooks.
> 
> I found the current behavior of the pwm_bl driver a little unintuitive
> and non-linear. See patch 1 for a suggested fix for this.
> 
> [...]

Applied, thanks!

[1/1] ARM: dts: rockchip: Remove 0 point from brightness-levels on rk3288-veyron
      commit: 225c59b9235a421cdb219be5fbc13126a49714a6

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
