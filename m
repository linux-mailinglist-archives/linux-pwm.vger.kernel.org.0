Return-Path: <linux-pwm+bounces-5397-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 04D91A81EDA
	for <lists+linux-pwm@lfdr.de>; Wed,  9 Apr 2025 09:57:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 809837A5ED3
	for <lists+linux-pwm@lfdr.de>; Wed,  9 Apr 2025 07:56:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A832825A35E;
	Wed,  9 Apr 2025 07:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rw2v9q08"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B43425A348;
	Wed,  9 Apr 2025 07:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744185461; cv=none; b=cLGKts3XXJ4o5lW10OqCm6NqCv3DkvCzq62qGRKnKG7wTagsOksR2GAhgFvjEg7k2xb5CoBG5EnRAY4w7tc+kTI7QeM0Anw+nHaR76y8MaaZ+n5dyBmlMYDwdsMd7s3nUYE3bq2yJ06WtcTFC7GJ1RA/Or0icqoZR5uFz2ITWaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744185461; c=relaxed/simple;
	bh=EUUG9DHhySYxln3x01p4RrX+4nqYuXoYoX7Cofr3TbM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dE6QUfRTNj56z84oBnHdxed/3+um2uxc4VnEQuHzf+/CAtMG9BHuq/fhteFbkfje40samKjgCSUmrV5LTsPucKHPTx3RNDTADYZ7M2dmvI+UOwzVM9/HpkK5JwZKNKWTlDJwDd7msfmmv6Q9iqlDhxxopdC9RsLuOip6Rv/WYOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rw2v9q08; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FF2FC4CEE3;
	Wed,  9 Apr 2025 07:57:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744185460;
	bh=EUUG9DHhySYxln3x01p4RrX+4nqYuXoYoX7Cofr3TbM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rw2v9q08XZj3ULwElQzsO94gNVctyG7DE0E90gXDLIQIQk4lNfomDBjoLaefx6Ezo
	 6Zg2bVwomvPwUB9sHJcFVvoWDFLoMFDZcinlsq1MRAAVX6NK7tvQgDb1vfwDTpF87D
	 Jy3JEq/7ML9R7OB05UBm0OOzZS9DnIwhnZTYbK65MlNhFpfChT/nFZ26UxHV9paFtZ
	 L7gdcrxyJxZBi3nFPanS9lYUSE54/+P594wVbIc2Mhqb1vtOkUiwG8MzTMPoxDRAJ4
	 K4gl7nApneBwWI1g3P1mj3nfF3eWjF7qYGkWSi5W43O+8G3WqALpNdvNfejhGk/F0d
	 g9tx6AuYLrjfQ==
Date: Wed, 9 Apr 2025 09:57:38 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Longbin Li <looong.bin@gmail.com>
Cc: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Chen Wang <unicorn_wang@outlook.com>, 
	Inochi Amaoto <inochiama@gmail.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, ghost <2990955050@qq.com>, linux-pwm@vger.kernel.org, 
	devicetree@vger.kernel.org, sophgo@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH 1/2] dt-bindings: pwm: sophgo: add pwm controller for
 SG2044
Message-ID: <20250409-koel-of-delightful-glee-aa0a01@shite>
References: <20250407072056.8629-1-looong.bin@gmail.com>
 <20250407072056.8629-2-looong.bin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250407072056.8629-2-looong.bin@gmail.com>

On Mon, Apr 07, 2025 at 03:20:38PM GMT, Longbin Li wrote:
> From: ghost <2990955050@qq.com>
> 
> Add compatible string for PWM controller on SG2044.
> 
> Signed-off-by: Longbin Li <looong.bin@gmail.com>

Messed SoB and From.

Use known identities, not ghosts.

Best regards,
Krzysztof


