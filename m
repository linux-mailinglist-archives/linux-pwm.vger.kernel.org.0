Return-Path: <linux-pwm+bounces-2197-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 74B838CA361
	for <lists+linux-pwm@lfdr.de>; Mon, 20 May 2024 22:37:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2EFEA281277
	for <lists+linux-pwm@lfdr.de>; Mon, 20 May 2024 20:37:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC1281386B7;
	Mon, 20 May 2024 20:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sn+UZqAs"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F732D27A;
	Mon, 20 May 2024 20:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716237466; cv=none; b=vGX1LaXcIFnUZnmuFlazwRd8pBXQVPE8fnoclipTPDx/Eb4RkzBq1b31SLrGByj4b09abnaMPi1erUSXztnUD8W4sf6D7GNIB+aohpuDg1vR4wz/xDUsHBxG0g6NVuRe+b+bKiB4bJYDHy1V5W0HYX6H+HNhurrijE8RB9KdB0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716237466; c=relaxed/simple;
	bh=CCDpO1f3/DyeYnMBOFPswYrvujmtDwPbY6svLv1+5Uc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XzAXzcghnWT92ABgbWMrxVaYS4rsUXgGsM1oq2j95xUDgZv5P+9Er/5Yg9Rvib9UQc7x2i+pOe5FkspuLBMwkcWoh4aG73h9pwl5lBYXVAn3ri3+m8PrZZ08cWgJoehJbUpyxcJRGl4aLz1Wh9iki8UWHYzEz9dmkJTKH3OI8GY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sn+UZqAs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27F00C2BD10;
	Mon, 20 May 2024 20:37:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716237465;
	bh=CCDpO1f3/DyeYnMBOFPswYrvujmtDwPbY6svLv1+5Uc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Sn+UZqAsnPVdLZkpaFTp0u/dwk1vc6s/hnsBJ0wJQN69Q1heRyxqb4C7tIM1329rO
	 +wgTf7ZjQy0rUXfjhzy8v/cIrQYl6QinGfstXMaMKSmP/wZ4TLlc/G183aoUJkzY0p
	 M7SOwdh6dgVLaTXJT80jnmxyNoQgtKTaqXW3M8JcMSr78neowiXQQ8w/RosephGSUO
	 BPk1a2porct+M4PYQivZ8A4YWmcyINMvquBa4sViGjnYQhP0x9x8t/ObCdQZcsUGgE
	 9HcKkwOAgaGqT+0txW8auBS8153gGUsBYGiieeZl2mxPdeK9zqrQB47h0KBaYgC1Z4
	 +Zoal5HQhlJKw==
Date: Mon, 20 May 2024 15:37:44 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Conor Dooley <conor@kernel.org>
Cc: devicetree@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	linux-kernel@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Chris Packham <Chris.Packham@alliedtelesis.co.nz>,
	linux-pwm@vger.kernel.org,
	Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v1] dt-bindings: pwm: describe the cells in #pwm-cells in
 pwm.yaml
Message-ID: <171623746170.1438468.2698160248963859712.robh@kernel.org>
References: <20240517-patient-stingily-30611f73e792@spud>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240517-patient-stingily-30611f73e792@spud>


On Fri, 17 May 2024 18:38:46 +0100, Conor Dooley wrote:
> From: Conor Dooley <conor.dooley@microchip.com>
> 
> When commit 89650a1e3b6f ("dt-bindings: pwm: Convert PWM bindings
> to json-schema") converted the pwm provider section of the text binding
> to dt-schema it also updated all references to pwm.txt in pwm provider
> bindings to pwm.yaml.
> 
> Most pwm provider bindings had a reference to pwm.txt as it contains a
> description of what the cells in #pwm-cells are, albeit in the consumer
> section of the document. Only information in the provider section of the
> document was moved to the yaml binding, and it contains no information
> about the cell format, making all references to it for the cell format
> unhelpful.
> 
> Fixes: 89650a1e3b6f ("dt-bindings: pwm: Convert PWM bindings to json-schema")
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> ---
> 
> I yoinked the wording from pwm.txt. Having "Typically" feels a bit
> clumsy, but a given provider is free to override that order AFAIU.
> 
> CC: Chris Packham <Chris.Packham@alliedtelesis.co.nz>
> CC: Guenter Roeck <linux@roeck-us.net>
> CC: Uwe Kleine-König <ukleinek@kernel.org>
> CC: Rob Herring <robh@kernel.org>
> CC: Krzysztof Kozlowski <krzk+dt@kernel.org>
> CC: Conor Dooley <conor+dt@kernel.org>
> CC: linux-pwm@vger.kernel.org
> CC: devicetree@vger.kernel.org
> CC: linux-kernel@vger.kernel.org
> ---
>  Documentation/devicetree/bindings/pwm/pwm.yaml | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


