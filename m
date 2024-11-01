Return-Path: <linux-pwm+bounces-4009-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A1379B98DB
	for <lists+linux-pwm@lfdr.de>; Fri,  1 Nov 2024 20:45:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 062C2280FCD
	for <lists+linux-pwm@lfdr.de>; Fri,  1 Nov 2024 19:45:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C1E61D07AB;
	Fri,  1 Nov 2024 19:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QWU7F0mo"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EC2A1CACF2;
	Fri,  1 Nov 2024 19:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730490347; cv=none; b=QcjNE941eRBtwSSe95NJnBqUPTv5eyb4s1SaTGjbevgMbJciZ42Oh6hKjULdaa8ajAWUU+N28zCN7BlzWLqJLfzKkaqpBhCk/3GaFEoEpEWNy9YKPADEj6O4eEIy4WmYM0J4OdH979NSEVTJh5bcbQG4zw58B7wcG7ju4/qehkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730490347; c=relaxed/simple;
	bh=YWNoNC6IgOJgm0SF/tIFJ7L/6qpPeiZn6M9zbN/xeVg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X7m1IuowlO4RF6Exoe6xIARw/EyP81rvcIILVZtY4xMVQqQLiGRUp9/ZQexeRHbNZD0zBiiROpQDQfkAyOFLIGF9sFObHoFCqKP8PTZf2uLywacoCvq/Putq4+ePxw3395U05HS0L+oOKwuoHjLgA+sMypElICdxTsSIaRRjTWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QWU7F0mo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DE14C4CECD;
	Fri,  1 Nov 2024 19:45:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730490346;
	bh=YWNoNC6IgOJgm0SF/tIFJ7L/6qpPeiZn6M9zbN/xeVg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QWU7F0mohIBlgoCwzDfa6NQlqoHqC2bj57eoIluqRilmnwj6nOem5x/QrCxAleoHi
	 Swc75tHM+cVEVIU0yz3iX2upl8vnUkU1C5Qy8ccyvP3Npsv9DSUXwWdgK32QewocNn
	 VWUiJ+NstQvLI4HtaZOPIX2/U/1Zo+9tZhp1BYHvPSCjOO/yB7IOQO6uJ29BskLVVL
	 JfaAwiJGOvRdd4kW6Je9o9mzvj9tQix7/QRez4oCD45RNRYif9XUeKh6nEG8gbm0X2
	 3cS4Ui9uP5AnZlW2Evr0M8NsqBnI+n1FS6ISMnOW/N1kbjXkBy23La2jKcTC+I7H0r
	 +GnB2NEmgRVZA==
Date: Fri, 1 Nov 2024 14:45:44 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Stanislav Jakubek <stano.jakubek@gmail.com>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, Orson Zhai <orsonzhai@gmail.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	linux-pwm@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: pwm: sprd,ums512-pwm: convert to YAML
Message-ID: <173049034404.4086958.11176792870448395104.robh@kernel.org>
References: <ZyH-JASRcpMXYsmH@standask-GA-A55M-S2HP>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZyH-JASRcpMXYsmH@standask-GA-A55M-S2HP>


On Wed, 30 Oct 2024 10:36:36 +0100, Stanislav Jakubek wrote:
> Convert the Spreadtrum/Unisoc UMS512 PWM controller bindings to DT schema.
> Adjust filename to match compatible. Drop assigned-* properties as these
> should not be needed.
> 
> Signed-off-by: Stanislav Jakubek <stano.jakubek@gmail.com>
> ---
>  .../devicetree/bindings/pwm/pwm-sprd.txt      | 40 -----------
>  .../bindings/pwm/sprd,ums512-pwm.yaml         | 66 +++++++++++++++++++
>  2 files changed, 66 insertions(+), 40 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/pwm/pwm-sprd.txt
>  create mode 100644 Documentation/devicetree/bindings/pwm/sprd,ums512-pwm.yaml
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


