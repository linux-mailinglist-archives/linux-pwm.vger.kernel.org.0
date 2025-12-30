Return-Path: <linux-pwm+bounces-7834-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BEF0CEA60E
	for <lists+linux-pwm@lfdr.de>; Tue, 30 Dec 2025 19:00:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E8BAD301C956
	for <lists+linux-pwm@lfdr.de>; Tue, 30 Dec 2025 17:59:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A32232B99C;
	Tue, 30 Dec 2025 17:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YLuBSuec"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 521F519E819;
	Tue, 30 Dec 2025 17:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767117595; cv=none; b=nuR1hoIbm7zADs2zXyxwMtVeBu+kjM/i7OusKubYzdpBhG/LEU+rVYvlYUs+unFOX937UV64/elezWF8VIjQN6BWAuoCqxy86zcNGAPKULrM+4fTEeWnDnojyJev+rpejWHEQ2QVWT1CLip3WJHYYjLe4GHnf3P64FUIsNfyVdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767117595; c=relaxed/simple;
	bh=OltSCu/7tnyCIgZ6hhfpQMRXS2NygrfmMJuxneFazgM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HqevPEX6D7Fe4Kxn29DtlAb+58zFQCKP7neC/SktmshaeOJz2uTOmRbzRUqBnW/X1u0/7bHJdv59UciXIVO+PDJIuX/QqnILLLiewOfqF8M55GafyBTGwh8B6gHci+BZWnWkthSvXzFExMc9kmheG/UX4cftlUxoE7xZHalPiUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YLuBSuec; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2E3FC4CEFB;
	Tue, 30 Dec 2025 17:59:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767117595;
	bh=OltSCu/7tnyCIgZ6hhfpQMRXS2NygrfmMJuxneFazgM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YLuBSuecOGLtn1aUSL4LEP9raB7yKl4ykGmqlfpoaVUlcRr606WNEduR8ADaz5fI9
	 CaYsl/F5yUYPe7SbFXj575fwvk2/DrEGm1J8AhwNbNU1GIGwQWfOsR+u1G/gIthTk7
	 O5uFYkLh0UQSOAV6tKnljsLl3H9v+2HGjSDvSYI+X6QoqANAWhdX8MbrF8V2VQFDF2
	 d3YIlSRzq7Npcgv7L637pKEvPz9fE1ryF4XnJWvN1mepvUPXXQvSkgezRkX1ogrUXd
	 big56cIOW9iouM1/vzMZ6nqPV4YA/RgDNh0RzWJw8WSvbnR5eJgAz9IRCXemopBHFs
	 ff7cd7UtMPfMQ==
Date: Tue, 30 Dec 2025 11:59:53 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Vladimir Zapolskiy <vz@mleia.com>
Cc: Conor Dooley <conor+dt@kernel.org>,
	Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-pwm@vger.kernel.org, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Frank Li <Frank.Li@nxp.com>
Subject: Re: [PATCH 1/2] dt-bindings: pwm: nxp,lpc32xx-pwm: Specify clocks
 property as mandatory
Message-ID: <176711759312.868220.4508247636976387030.robh@kernel.org>
References: <20251228224907.1729627-1-vz@mleia.com>
 <20251228224907.1729627-2-vz@mleia.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251228224907.1729627-2-vz@mleia.com>


On Mon, 29 Dec 2025 00:49:06 +0200, Vladimir Zapolskiy wrote:
> Both described in the binding PWM controllers depend on supply clocks,
> thus it's necessary to specify 'clocks' property in the correspondent
> device tree nodes.
> 
> Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
> ---
>  Documentation/devicetree/bindings/pwm/nxp,lpc3220-pwm.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


