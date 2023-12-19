Return-Path: <linux-pwm+bounces-574-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 944B981834A
	for <lists+linux-pwm@lfdr.de>; Tue, 19 Dec 2023 09:26:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6C3F1C23894
	for <lists+linux-pwm@lfdr.de>; Tue, 19 Dec 2023 08:26:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DCF912B6D;
	Tue, 19 Dec 2023 08:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vAgyGFav"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C00412B69;
	Tue, 19 Dec 2023 08:26:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E70BC433C8;
	Tue, 19 Dec 2023 08:26:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702974402;
	bh=RXS2+8wrVZn1cgNBgmJ9bhqenDhrBEvY/SJyQRX+so4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vAgyGFavYPKYx8aEZelEFOgs9QsVWVyFeThCQa33plPSsm7YnONT5BTXGXcm4XWf9
	 u/PbDO5aPyJD0lV3oUoY/7RebLbJ7z/Yts4v8PWJARO9BECPXlJIHpzhBDAmWzf8tp
	 15qkcrZSVKMBaD276t/wvexLctnWI3Q4nnuKa2Qtg4GfnDZZhFDhD//sB2248Cj0Bb
	 qBBdpEEgQgnEN6TXQFCxyQvHIIt2DElrk+tb3neD9Sb7D86TZTTne02Mh/KEP/ejK5
	 zlFJnxInYj8UFd5g3M2+dwdd1kO7jhcS/tddhdiKzToywOGnvAO9NpVfDVplgt8aZL
	 NZdfZ2aSPiXSQ==
Date: Tue, 19 Dec 2023 16:26:39 +0800
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Thierry Reding <thierry.reding@gmail.com>,
	Benson Leung <bleung@chromium.org>,
	Guenter Roeck <groeck@chromium.org>, linux-pwm@vger.kernel.org,
	chrome-platform@lists.linux.dev, kernel@pengutronix.de,
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] pwm: cros-ec: Drop documentation for dropped struct
 member
Message-ID: <ZYFTvzsw1-z_MAZ_@google.com>
References: <20231219063316.167905-2-u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231219063316.167905-2-u.kleine-koenig@pengutronix.de>

On Tue, Dec 19, 2023 at 07:33:17AM +0100, Uwe Kleine-König wrote:
> Recently an unused member was removed from struct cros_ec_pwm_device,
> but the kernel doc wasn't adapted accordingly. Catch up and drop the
> documentation, too.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202312190757.O4M9dsln-lkp@intel.com/
> Fixes: ffb150737fee ("pwm: cros-ec: Drop unused member from driver private data")
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Reviewed-by: Tzung-Bi Shih <tzungbi@kernel.org>

