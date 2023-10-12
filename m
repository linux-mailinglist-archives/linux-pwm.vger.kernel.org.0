Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31E277C69AE
	for <lists+linux-pwm@lfdr.de>; Thu, 12 Oct 2023 11:32:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235329AbjJLJcM (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 12 Oct 2023 05:32:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229981AbjJLJcL (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 12 Oct 2023 05:32:11 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F3ECA9;
        Thu, 12 Oct 2023 02:32:09 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00447C433C9;
        Thu, 12 Oct 2023 09:32:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697103129;
        bh=AxnUIDA/e9qLgCAiZD8tmnZjwfIJgA9SE3BJ38gxlj0=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=Qp2LYErre2QxrdDzNBioN4uiVWPGAUp15Nl76JtJIahmNjk0Kf+bcPdT/BCsqJZtS
         Eclf7huwILdvxAU2VV0Q+9sbFpJYik2looPgWoF0f+jhk3tGcL0aY/evXGR8FyyswX
         4/rY0VGGnirVtJGBUzfXEtIaGH2yUO41PfXBv99m+whYHwyCECIUdtdW0ybcOFos8v
         p/BUwzHPaM+PD7IcnRYbOG+02wY8cvEIP13k810T0RfKu2nouSB711IZU2m377sOow
         JGb+5AVkFS7wxC86dq7sDAiqcMoHY9tZ10q8RWjY8UjYcVWwxOH94IVhzUZaftiljY
         FQYvCVI6SLyOw==
From:   Lee Jones <lee@kernel.org>
To:     Lee Jones <lee@kernel.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Aisheng Dong <aisheng.dong@nxp.com>, linux-pwm@vger.kernel.org,
        linux-fbdev@vger.kernel.org, Helge Deller <deller@gmx.de>,
        dri-devel@lists.freedesktop.org,
        Thierry Reding <thierry.reding@gmail.com>,
        kernel@pengutronix.de
In-Reply-To: <20231009093223.227286-1-u.kleine-koenig@pengutronix.de>
References: <20231009093223.227286-1-u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v4] backlight: pwm_bl: Disable PWM on shutdown, suspend
 and remove
Message-Id: <169710312672.1151305.17287126942774002014.b4-ty@kernel.org>
Date:   Thu, 12 Oct 2023 10:32:06 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Mon, 09 Oct 2023 11:32:23 +0200, Uwe Kleine-König wrote:
> Since commit 00e7e698bff1 ("backlight: pwm_bl: Configure pwm only once
> per backlight toggle") calling pwm_backlight_power_off() doesn't disable
> the PWM any more. However this is necessary to suspend because PWM
> drivers usually refuse to suspend if they are still enabled.
> 
> Also adapt shutdown and remove callbacks to disable the PWM for similar
> reasons.
> 
> [...]

Applied, thanks!

[1/1] backlight: pwm_bl: Disable PWM on shutdown, suspend and remove
      commit: 40da4737717b252fd01d92ff38d3b95a491167cc

--
Lee Jones [李琼斯]

