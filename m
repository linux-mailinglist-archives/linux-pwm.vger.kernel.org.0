Return-Path: <linux-pwm+bounces-6562-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 160E4AEC1B6
	for <lists+linux-pwm@lfdr.de>; Fri, 27 Jun 2025 23:07:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF0311C413FF
	for <lists+linux-pwm@lfdr.de>; Fri, 27 Jun 2025 21:07:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24A1D2ECD33;
	Fri, 27 Jun 2025 21:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dzt3tiMF"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E93A81E8322;
	Fri, 27 Jun 2025 21:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751058422; cv=none; b=efp+Q0QbXCOTd+OIiYQ7djzoOGYNVtqxtlOT9G0nGd8XXvDA1hx2/dimkgF4GaamAjCZpRK/TbyjwwgPgS/R1CZ2PXp2F2WNnqzXiLhPPhe9KPOEz/Z8qjAZMD/yWyf47mzrSlCu4XO2xTSdsLNnZXikB3YxNyr2n57cI1JHXbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751058422; c=relaxed/simple;
	bh=902EI54Gb+xcSsy1G5rvjQtc51kp9GqWt45lEhPAzSc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N1OFaSPipWrcOOh744DX8GkSVh4G4t7XF01SP484ZBF+2+wWU/496ActPTYmcQpkmdcDzbqaA/F8HZ5SMNaUl7IZ7a7DaLiLo9EzcKPOWMrnuXgYdRQYp7XUn0/KIaS2KuTeNIBgV7BDT4q0WPbQaeAgnl9dBIWXxM66JHMPbYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dzt3tiMF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6039AC4CEE3;
	Fri, 27 Jun 2025 21:07:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751058421;
	bh=902EI54Gb+xcSsy1G5rvjQtc51kp9GqWt45lEhPAzSc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Dzt3tiMFt0adkI2hdTvKU95XriiRM/5Uu6Ikh9prqSgdF/TGmmht6ZY6HEe68R1oI
	 jjH1jZC370En+rknZQ3h02w4hkMtewNge3/9LopYy57DuQa3ah1Wttcr4SWSMX9Kn9
	 R9VoB3taXJW+UosJTvtGDo/Oskl/1QQYxAdh58qSDwwjb6PR5uOW+hsBI2q1nUtVZf
	 qK5bMgmefV90KMSRXS3ua6PgP+DH8hBE0RjOo7gQ7Addr1h0rLPON7/Lq3EBntK4Nl
	 wrTBUaSHtSrXvtDYk0ZXOTjD1YgTv4+tvjIfDwhrL743yPDjxooy+kfJvDrbxB8dgb
	 GkjQd6dAjyIpA==
Date: Fri, 27 Jun 2025 16:07:00 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Vladimir Zapolskiy <vz@mleia.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
	linux-pwm@vger.kernel.org, imx@lists.linux.dev,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>,
	linux-arm-kernel@lists.infradead.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>
Subject: Re: [PATCH v2 1/1] dt-bindings: pwm: convert lpc32xx-pwm.txt to yaml
 format
Message-ID: <175105842018.146239.1932204219454180284.robh@kernel.org>
References: <20250625161909.2541315-1-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250625161909.2541315-1-Frank.Li@nxp.com>


On Wed, 25 Jun 2025 12:19:08 -0400, Frank Li wrote:
> Convert pc32xx-pwm.txt to yaml format.
> 
> Additional changes:
> - add ref to pwm.yaml
> - add clocks
> - restrict #pwm-cells to 3
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> change in v2
> - allow clocks, there are not clocks for nxp,lpc3220-motor-pwm, so not put
> into required.
> ---
>  .../devicetree/bindings/pwm/lpc32xx-pwm.txt   | 17 -------
>  .../bindings/pwm/nxp,lpc3220-pwm.yaml         | 44 +++++++++++++++++++
>  2 files changed, 44 insertions(+), 17 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/pwm/lpc32xx-pwm.txt
>  create mode 100644 Documentation/devicetree/bindings/pwm/nxp,lpc3220-pwm.yaml
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


