Return-Path: <linux-pwm+bounces-2856-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C3BA9378B8
	for <lists+linux-pwm@lfdr.de>; Fri, 19 Jul 2024 15:50:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BA661C21702
	for <lists+linux-pwm@lfdr.de>; Fri, 19 Jul 2024 13:50:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 301CC1422D1;
	Fri, 19 Jul 2024 13:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="t7IUVOMz"
X-Original-To: linux-pwm@vger.kernel.org
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E85A183A19;
	Fri, 19 Jul 2024 13:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721397047; cv=none; b=MXFxePBe9PHx5n/0L2yN9pk15I1o4rm0Ntb64/pwC9i6QwTCwWHhwOpdGXZIr8c9jXhK6XzOygl8H+IH7XUDVVdNWI4qmLhDOQoqjyVxRvWpYvdSiSAHQ5WTlKO0VwZ0biypNu5V+dsUS4Dd7vGUwLlVgbGGT2ckVNpmBAoK0gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721397047; c=relaxed/simple;
	bh=bB62eNn1Si6jo67dIW4Oct7GDuuKGuL0OJSsuqAUq38=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kg+OQtl3PCZypohwaDVOgebOdGc3MOHe0Bp7p50Wy4kLlnbMf2X3175Cw8Rl6/BTNq9F3b6KjfzTZ/OdZ0cZqpvXqKrr5bZkwsdzn5EUFHf5mSdUgFcH1QPRtyPZkXIMzC1secV1ZnCfKrf00ORi3xwP6vZg2i8ayYzsK+VaBas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=t7IUVOMz; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (81-175-209-231.bb.dnainternet.fi [81.175.209.231])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 6173473E;
	Fri, 19 Jul 2024 15:50:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1721397001;
	bh=bB62eNn1Si6jo67dIW4Oct7GDuuKGuL0OJSsuqAUq38=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=t7IUVOMzcZ0mwQUpW0UjfwzeHG6iQldkK0cOyH0hi2vHuT49faWsHBl6s8cmXjgJO
	 aUw9sve33iuqUB2kJH6FOwab8gpGWshlPGrKtGlcuzsq00NZGxRhlJBybXeLtQVsr7
	 ZSpXsUZfVzcqBfNfkRHDhg4tO0yZHQS0ZuWUhWAE=
Date: Fri, 19 Jul 2024 16:50:25 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: Frank Li <Frank.li@nxp.com>,
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-gpio@vger.kernel.org, linux-pwm@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	Clark Wang <xiaoning.wang@nxp.com>, Haibo Chen <haibo.chen@nxp.com>,
	Jindong Yue <jindong.yue@nxp.com>
Subject: Re: [PATCH 4/6] pwm: adp5585: add adp5585 PWM support
Message-ID: <20240719135025.GA637@pendragon.ideasonboard.com>
References: <20240716-adi-v1-0-79c0122986e7@nxp.com>
 <20240716-adi-v1-4-79c0122986e7@nxp.com>
 <u7xii4lfvjk6gbpmq7qtqckoznddiyno7xsaa74ufuxwdob532@wxuawwiwjpgm>
 <ZpfVNHQQaJvdnB+B@lizhi-Precision-Tower-5810>
 <CAOMZO5CGqMXmcUg=J0OOtsq4ZpnVD7GnpxzEQQQ1Cq_dR45Hwg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOMZO5CGqMXmcUg=J0OOtsq4ZpnVD7GnpxzEQQQ1Cq_dR45Hwg@mail.gmail.com>

On Wed, Jul 17, 2024 at 12:35:29PM -0300, Fabio Estevam wrote:
> On Wed, Jul 17, 2024 at 11:29 AM Frank Li <Frank.li@nxp.com> wrote:
> 
> > Thank you for you review. I just found someone already submit similar patch
> >
> > https://lore.kernel.org/linux-gpio/20240608141633.2562-5-laurent.pinchart@ideasonboard.com/
> >
> > Let's wait for laurent. If he is busy, I can rework base on the above one.
> 
> Adding Laurent.

Thanks Fabio.

I had a quick look at this series, and I think mine is better as it
supports more features and more chip variants.

-- 
Regards,

Laurent Pinchart

