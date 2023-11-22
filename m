Return-Path: <linux-pwm+bounces-131-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F33F7F4091
	for <lists+linux-pwm@lfdr.de>; Wed, 22 Nov 2023 09:52:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 07FB9B20996
	for <lists+linux-pwm@lfdr.de>; Wed, 22 Nov 2023 08:52:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F17B120B06;
	Wed, 22 Nov 2023 08:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FumuhebC"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D28741CAB1;
	Wed, 22 Nov 2023 08:52:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 368E5C433C8;
	Wed, 22 Nov 2023 08:52:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700643153;
	bh=IaDXazBFLgJLrCCZ5ZKPxuE8p+aXje9cOAE6DyMfjvs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FumuhebC0pIxSWvkdBcRS6gg8WnXhHAt1+f0qN71IHGokyZJK6RW5ndUk8ejYafvP
	 IgBssGm0RFtUSgupEmKnY/FvDzQ0YN4k+hJh8Kf70I3G0ENiYbkc5tLfp3dRCj2KTn
	 snUpzMXoo41NKmCOhsoiRXE/FtQsICjv8GppbQMoUZG+MOTDX/RL+ZjD79X19SDLe4
	 EagHofU6pVdNZxVHPE0JleKic3uxERIl6CeOMLkd9a0Ph/WUXw5U9VPv0gm9swyFC5
	 tRTsM6ZRFRJLYKiJPHQjyxPlq8D7jKy0noEDsqCRcdGoJ3d1hC6j2hwfd34VupzQ6T
	 5C7aPQWviiJOA==
Date: Wed, 22 Nov 2023 16:52:30 +0800
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Thierry Reding <thierry.reding@gmail.com>,
	Benson Leung <bleung@chromium.org>,
	Guenter Roeck <groeck@chromium.org>, linux-pwm@vger.kernel.org,
	chrome-platform@lists.linux.dev, kernel@pengutronix.de
Subject: Re: [PATCH v3 008/108] pwm: cros-ec: Make use of pwmchip_parent()
 macro
Message-ID: <ZV3BTtR7i_g4Yj53@google.com>
References: <20231121134901.208535-1-u.kleine-koenig@pengutronix.de>
 <20231121134901.208535-9-u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231121134901.208535-9-u.kleine-koenig@pengutronix.de>

On Tue, Nov 21, 2023 at 02:49:10PM +0100, Uwe Kleine-König wrote:
> struct pwm_chip::dev is about to change. To not have to touch this
> driver in the same commit as struct pwm_chip::dev, use the macro
> provided for exactly this purpose.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Reviewed-by: Tzung-Bi Shih <tzungbi@kernel.org>

