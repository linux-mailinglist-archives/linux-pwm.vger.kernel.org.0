Return-Path: <linux-pwm+bounces-5392-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DBC47A81396
	for <lists+linux-pwm@lfdr.de>; Tue,  8 Apr 2025 19:27:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C49E04A20A9
	for <lists+linux-pwm@lfdr.de>; Tue,  8 Apr 2025 17:27:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5569D23BD1C;
	Tue,  8 Apr 2025 17:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="unmgh+wx"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19EBC1D61A2;
	Tue,  8 Apr 2025 17:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744133229; cv=none; b=U9BTom7Ropp+Bjg22MrUR2NXQ3IzaqGuapdWe+n14hoONEt8LBOw2J8NypUW6RYI/EkwiqvKmKwb6aAZQSONN1K5+WBkdHW33MD7Lju+Os0oH36ES88gVQ+LmvpMg/j2eLgMhxKA/wkC8mLf7MbigJNhSF1dL8ZY3fnqsz2oNjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744133229; c=relaxed/simple;
	bh=aLx0mUhM3Bq/zV6SJmFIXECD9k2eFzF4YueLPJkyMII=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hJgQzYvSmaQiRQQ3pl7t+m98js5rbJs8oB+/5eQfWWnpXmiZ0vgEF0uLtW7H18Z0lzj3SCcY+ITOBCtfm3KMVFTqK5D9dHqrELZqT5+YfZh4ay0d5saO5t59x1nBQEA4EN84pxQVHixxlhoL+Gb/6VMvPH1Zlw2QI2OeBn1BukM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=unmgh+wx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C45CC4CEE5;
	Tue,  8 Apr 2025 17:27:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744133228;
	bh=aLx0mUhM3Bq/zV6SJmFIXECD9k2eFzF4YueLPJkyMII=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=unmgh+wxykjk9tR3YGgjNWRwY6ElejEHHU19KaQ8LEQI9JCTmcilRpLInBUaSzsw1
	 9kXAr58nGziKPUoa6ojX7Xo13s8sBUuOuo9CaESB03aKbim61OQX82m0m2xGWoG9VE
	 V5dqs9W2QuNRo2VktvYdu82zP6nXH8a5OAyqQ+so/auKaUGNf6osms70qvPd0qbmuw
	 7Nnk2xaG1yjD6uJK+t9h4xXDxgRKZFV2ckV3m3Pn3f117fHmmF//cLTR0GYrhueWJ4
	 f6saZ3+ro9C2gdKLf4fcqZgOcpVLyCDa8pal9JobmMFFdvwpjd6Qdd65+F7Xkhub99
	 CERiMnXgXtjGQ==
Date: Tue, 8 Apr 2025 12:27:07 -0500
From: Rob Herring <robh@kernel.org>
To: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	William Breathitt Gray <wbg@kernel.org>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Kever Yang <kever.yang@rock-chips.com>, linux-gpio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-pwm@vger.kernel.org, linux-iio@vger.kernel.org,
	kernel@collabora.com, Jonas Karlman <jonas@kwiboo.se>,
	Detlev Casanova <detlev.casanova@collabora.com>
Subject: Re: [PATCH 1/7] dt-bindings: pinctrl: rockchip: increase max amount
 of device functions
Message-ID: <20250408172707.GA2283098-robh@kernel.org>
References: <20250408-rk3576-pwm-v1-0-a49286c2ca8e@collabora.com>
 <20250408-rk3576-pwm-v1-1-a49286c2ca8e@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250408-rk3576-pwm-v1-1-a49286c2ca8e@collabora.com>

On Tue, Apr 08, 2025 at 02:32:13PM +0200, Nicolas Frattaroli wrote:
> With the introduction of the RK3576, the maximum device function ID used
> increased to 14, as anyone can easily verify for themselves with:
> 
>   rg -g '*-pinctrl.dtsi' '<\d+\s+RK_P..\s+(?<func>\d+)\s.*>;$' --trim \
>   -NI -r '$func' arch/arm64/boot/dts/rockchip/ | sort -g | uniq
> 
> Unfortunately, this wasn't caught by dt-validate as those pins are
> omit-if-no-ref and we had no reference to them in any tree so far.

Sounds like we need a way to disable that for validation. We'd need a 
dtc flag to ignore that and then set that flag for CHECK_DTBS.

Rob

