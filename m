Return-Path: <linux-pwm+bounces-5798-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E380AA6C78
	for <lists+linux-pwm@lfdr.de>; Fri,  2 May 2025 10:27:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D62D39A6AF1
	for <lists+linux-pwm@lfdr.de>; Fri,  2 May 2025 08:26:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7444224B0F;
	Fri,  2 May 2025 08:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R0k8s4JZ"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA1D61F426C;
	Fri,  2 May 2025 08:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746174423; cv=none; b=pvIlqlgWcweASvicizV2Mpof9vyOuG9DPb+1xyt2a8DiZNyaVy4Rd8xzb4cvg49RB0uazCjbHSknT5bT7xlQiauDr44EtOUVxIZYV3X/dpaMsonhqSUV1pFa3UmWIe7GVZGUlUMarThOQvGpvbfbO+0uTUQvlL10Ex5M28UwIzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746174423; c=relaxed/simple;
	bh=F83/aGQLPpi9JYaClKC8Nzfz8FWScdHIxxTOqvFD3Lc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NR583Y+CGA9pBRUV9p/Lz14vG0ExnyOkrc+5sVXCm1TGhZ0IWWqBjmFw8CnxT4HOnMleWrXMvbO9MSIlFgx8zYmc8j8GiHQStkTsCfRfwTvUGKkOa1+wp842ps8y1ytu0fHqqiCdz1ulMKiwrLsjoPWHs4oZes8mczUG+r/5nhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R0k8s4JZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2293AC4CEE4;
	Fri,  2 May 2025 08:26:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746174423;
	bh=F83/aGQLPpi9JYaClKC8Nzfz8FWScdHIxxTOqvFD3Lc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=R0k8s4JZFLJc79spjk3tbFhlExbLH/Pqqni3nBLdEJ5QEDhPKGMcBTogfFpvL223a
	 KNsUpr4VI1iYpnUZo+9XaNBjs5uaIPxMaEbPfXdpD20odD1UbpQQoBgLWTnjJTskOH
	 PV5QhtwXDlzyCrn4lCY6XTOjUctfJrnuDsj2fp9v7SUkO6a5Dk9Mr5k+YwF8kxNUg+
	 32Xy+rtLknUND/cuBzcwgSHzxCoTypsotVgRr7kaFpaSKMi+kuop5rxEyowhtcr+p+
	 evHrNWFNIQSLR5rW6Z65UrAx5PA2pNHCckEM63xHRqUHpp5obYbTbvxxLkYoCUeXYF
	 zmqiS1u2S1zVA==
Date: Fri, 2 May 2025 09:26:56 +0100
From: Lee Jones <lee@kernel.org>
To: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Kamel Bouhara <kamel.bouhara@bootlin.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Michael Walle <mwalle@kernel.org>, Mark Brown <broonie@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-input@vger.kernel.org, linux-pwm@vger.kernel.org,
	andriy.shevchenko@intel.com,
	=?iso-8859-1?Q?Gr=E9gory?= Clement <gregory.clement@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v7 02/11] mfd: Add max7360 support
Message-ID: <20250502082656.GF3865826@google.com>
References: <20250428-mdb-max7360-support-v7-0-4e0608d0a7ff@bootlin.com>
 <20250428-mdb-max7360-support-v7-2-4e0608d0a7ff@bootlin.com>
 <20250501125943.GN1567507@google.com>
 <D9LI2Y0J2KZY.15PIU2T55GIH0@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <D9LI2Y0J2KZY.15PIU2T55GIH0@bootlin.com>

On Fri, 02 May 2025, Mathieu Dubois-Briand wrote:

> On Thu May 1, 2025 at 2:59 PM CEST, Lee Jones wrote:
> > On Mon, 28 Apr 2025, mathieu.dubois-briand@bootlin.com wrote:
> >
> >> From: Kamel Bouhara <kamel.bouhara@bootlin.com>
> >> +static int max7360_probe(struct i2c_client *client)
> >> +{
> >> +	struct device *dev = &client->dev;
> >> +	struct regmap *regmap;
> >> +	int ret;
> >> +
> >> +	regmap = devm_regmap_init_i2c(client, &max7360_regmap_config);
> >> +	if (IS_ERR(regmap))
> >> +		return dev_err_probe(dev, PTR_ERR(regmap), "Failed to initialise regmap\n");
> >
> > dev_err_ptr_probe()
> >
> 
> I believe dev_err_ptr_probe() is meant to be used for the opposite case,
> where the variable holding the error is an int but the function has to
> return a pointer. Here regmap is a pointer but we have to return an int,
> so I believe neither dev_err_ptr_probe() or any similar macro can really
> help us.

Ah yes, you're right.  Disregard.

-- 
Lee Jones [李琼斯]

