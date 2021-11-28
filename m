Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 416464604BC
	for <lists+linux-pwm@lfdr.de>; Sun, 28 Nov 2021 06:49:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231655AbhK1Fwv (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 28 Nov 2021 00:52:51 -0500
Received: from rere.qmqm.pl ([91.227.64.183]:8587 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231162AbhK1Fuu (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Sun, 28 Nov 2021 00:50:50 -0500
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 4J1yDh5CCGzWG;
        Sun, 28 Nov 2021 06:47:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1638078453; bh=+Cj+BB/A2FsyTFVTgsdgLhKnhMnYskAogn3uwYKOvvs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mDvzO3ZNwgpRiDuAFQm9+pmxug6iiRogj8KsZ2DHrmVfKL9MWSJm9HIQ2sF53TWpd
         L0Cxo/iC7TwwP9CzggOdtnsG8yh61uH/yiyeGKtUaLSuvka7WWpkL+2fp2a7+f17zz
         LHjYvTh7JA7FV6iyq6nBwmZrvFWcELXXfV45m1RCWxlWHolAHnoJwfNUJM70pyRscX
         ENAaoeowyKRpJRtQFR1i2aNe9zfcheSfjlOzpYaHMu1obJu43gZXlYrjkkdRz+K8NR
         sXFW2VroLhE37GnXrisZfCB+nIxUD7dB5BTDMrVasYp8kMZWagiL+RGR5M01Pdi/50
         yPZ70dtIdnSCg==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.103.3 at mail
Date:   Sun, 28 Nov 2021 06:47:31 +0100
From:   =?iso-8859-2?Q?Micha=B3_Miros=B3aw?= <mirq-linux@rere.qmqm.pl>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Lee Jones <lee.jones@linaro.org>,
        Uwe =?iso-8859-2?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, Nishanth Menon <nm@ti.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-mmc@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-clk@vger.kernel.org, David Heidelberg <david@ixit.cz>
Subject: Re: [PATCH v15 12/39] drm/tegra: gr2d: Support generic power domain
 and runtime PM
Message-ID: <YaMX89bRBlqh0MvB@qmqm.qmqm.pl>
References: <20211114193435.7705-1-digetx@gmail.com>
 <20211114193435.7705-13-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211114193435.7705-13-digetx@gmail.com>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Sun, Nov 14, 2021 at 10:34:08PM +0300, Dmitry Osipenko wrote:
> Add runtime power management and support generic power domains.
[...]
> @@ -104,10 +127,17 @@ static int gr2d_open_channel(struct tegra_drm_client *client,
>  			     struct tegra_drm_context *context)
>  {
>  	struct gr2d *gr2d = to_gr2d(client);
> +	int err;
> +
> +	err = pm_runtime_resume_and_get(client->base.dev);
> +	if (err)
> +		return err;
>  
>  	context->channel = host1x_channel_get(gr2d->channel);
> -	if (!context->channel)
> +	if (!context->channel) {
> +		pm_runtime_put(context->client->base.dev);

Could host1x_channel_get/put() handle pm_runtime* calls ? I would expect
this to be common code for the users.

BTW, pm_runtime_resume_and_get() uses different dev than
pm_runtime_put() in the error path - is this intended?

Best Regards
Micha³ Miros³aw
