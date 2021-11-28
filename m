Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13F14460477
	for <lists+linux-pwm@lfdr.de>; Sun, 28 Nov 2021 06:43:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233173AbhK1FqS (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 28 Nov 2021 00:46:18 -0500
Received: from rere.qmqm.pl ([91.227.64.183]:49674 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230230AbhK1FoR (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Sun, 28 Nov 2021 00:44:17 -0500
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 4J1y561xCxzGX;
        Sun, 28 Nov 2021 06:40:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1638078060; bh=euRkxERs/Vo+Ncwnc6oh+QQPM82cBPQuQuUB2BgzLnk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LY3ChcHhLpC97uysDR/7nppfcxComB2E48G/CSr/GJWMZpY0nUf2Ozt/QdF3bO27D
         KVVscNOrPrvjDeFDDvD8xGhXTpYyqBgTMYDKLE9wEICL5bDVx6hBtk8ejpU6BrId79
         vbWsoB/iTmCLm+bLT0tuvFrL4/nVF7nyYWv4tALAyWWX2iU7ISeiyJa/5FSEeoDtm6
         egb154gg0fV3kqNymh1/NYzbwJKJ0ezYVFUVXr4cbByKt/7l8pm0u2iIP/DReChzc2
         cj5XNAxcI2vANrMDBXNTTKYQJcaUTS+V2hD4R7+BDKXqWKOMu+D+3chFvhgLVLi9p7
         Ujd618hPUSMCQ==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.103.3 at mail
Date:   Sun, 28 Nov 2021 06:40:56 +0100
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
Subject: Re: [PATCH v15 00/39] NVIDIA Tegra power management patches for 5.17
Message-ID: <YaMWaKqQ+c8G08mJ@qmqm.qmqm.pl>
References: <20211114193435.7705-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211114193435.7705-1-digetx@gmail.com>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Sun, Nov 14, 2021 at 10:33:56PM +0300, Dmitry Osipenko wrote:
> This series adds runtime PM support to Tegra drivers and enables core
> voltage scaling for Tegra20/30 SoCs, resolving overheating troubles.
> 
> All patches in this series are interdependent and should go via Tegra tree
> for simplicity.
[...]

I would suggest pushing all the fixes to the front of the series (those are
at least patches 1, 3, 17, 27-31 and 39).

Best Regards
Micha³ Miros³aw
