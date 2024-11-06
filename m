Return-Path: <linux-pwm+bounces-4037-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 479A19BE511
	for <lists+linux-pwm@lfdr.de>; Wed,  6 Nov 2024 12:01:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D799282AE5
	for <lists+linux-pwm@lfdr.de>; Wed,  6 Nov 2024 11:01:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E1151DE8AD;
	Wed,  6 Nov 2024 11:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XUuSuoZM"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 421061DE89A;
	Wed,  6 Nov 2024 11:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730890853; cv=none; b=HHBjTvxXG3E8EfFz0YiVDXRntSEzyf4Di5SCLvc2BVFxkRG35+i1VEJkh+5WePvcHRPpln2BQWVm7RiD6iC0TtoPLXs0ZdG7KtBhAN+kuxjTXEa8fHJaFfs09UqVYCfS9bU1Lntbj8chbnE70CP39krmfde2ap0nj0ryxK3rLcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730890853; c=relaxed/simple;
	bh=ZC3QCMHYErbSGzgV1QmL7jUEKIIt60BFfDB2EWuwths=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EOxuKJd54GTazP445gsNXx1NnbG1xpHo5rDs3jD3OG6uHEcY/dasmZRR6oyH0OFgffiuZ9i3LVFcrE9W9KWzBnvExw/WzhFJLyFGQwXFckYfJXfb8+x4SyqOfoaEMckca9vYLtvwOdfKspp96z5yxf+DEi+u1YeqMY+pD86QQtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XUuSuoZM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B958C4CECD;
	Wed,  6 Nov 2024 11:00:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730890852;
	bh=ZC3QCMHYErbSGzgV1QmL7jUEKIIt60BFfDB2EWuwths=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XUuSuoZMX5ra6tDJFX+mApy0pqlZxrP3Zzekuvj8cLxvq44zpJ8HVyneLV8nb9tcd
	 599f0HCcAK8+DQ8syHeX/ve13OcssEiszKpKnBzpfXq4om3rA8ZFxaOusDddsp61UB
	 QRpc1TMz3GH2ym4bs/eOorsMwF2o8qW7fG6Lzef5oL34qvLPcwCTlIgKmE9B5JgynG
	 LcEqyHWuomlShygX59Xu4OdjMQMh6mN+P+i82ojlKSJ13mi+IbRiO4x/9EmUB+JnDX
	 7tFVz1Lt1ZPNtm74MTOegeKD94UN/Qm3yeOtFHlSm6GgK7RPnTHQU+KvpiC91X4QL8
	 OWfnY94Tq8t5g==
Date: Wed, 6 Nov 2024 11:00:46 +0000
From: Lee Jones <lee@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Linus Walleij <linus.walleij@linaro.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sean Wang <sean.wang@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	linux-mediatek@lists.infradead.org, linux-gpio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	upstream@airoha.com, benjamin.larsson@genexis.eu,
	ansuelsmth@gmail.com, linux-pwm@vger.kernel.org
Subject: Re: (subset) [PATCH v9 4/6] dt-bindings: mfd: Add support for Airoha
 EN7581 GPIO System Controller
Message-ID: <20241106110046.GR1807686@google.com>
References: <20241023-en7581-pinctrl-v9-0-afb0cbcab0ec@kernel.org>
 <20241023-en7581-pinctrl-v9-4-afb0cbcab0ec@kernel.org>
 <173088099542.3237297.18018729158887853624.b4-ty@kernel.org>
 <ZyssJpR7xwbMzUsm@lore-desk>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZyssJpR7xwbMzUsm@lore-desk>

On Wed, 06 Nov 2024, Lorenzo Bianconi wrote:

> On Nov 06, Lee Jones wrote:
> > On Wed, 23 Oct 2024 01:20:04 +0200, Lorenzo Bianconi wrote:
> > > Add support for Airoha EN7581 GPIO System Controller which provide a
> > > register map for controlling the GPIO, pinctrl and PWM of the SoC via
> > > dedicated pinctrl and pwm child nodes.
> > > 
> > > 
> > 
> > Applied, thanks!
> > 
> > [4/6] dt-bindings: mfd: Add support for Airoha EN7581 GPIO System Controller
> >       commit: f49f37f3cfe1482d4dc77d26f3e8c38eab630d52
> > 
> > --
> > Lee Jones [李琼斯]
> > 
> 
> Hi Lee,
> 
> according to my understanding this patch has been already applied by Linus
> here:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git/commit/?h=devel&id=50dedb1eb1e6755ccab55f6140916c2d192be765

An interesting choice.  Linus?

-- 
Lee Jones [李琼斯]

