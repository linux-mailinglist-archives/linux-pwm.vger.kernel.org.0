Return-Path: <linux-pwm+bounces-3205-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D237A975BCF
	for <lists+linux-pwm@lfdr.de>; Wed, 11 Sep 2024 22:35:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 862841F238E2
	for <lists+linux-pwm@lfdr.de>; Wed, 11 Sep 2024 20:35:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0C2C1BB69E;
	Wed, 11 Sep 2024 20:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="g1GYA1BV"
X-Original-To: linux-pwm@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 149FF1B9B45;
	Wed, 11 Sep 2024 20:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726086878; cv=none; b=phrD5ESF+rqrFvzrii+4pZX8BhQqjKg/78OoMmzZBvj8lBOP+gTw7AFOq1ZS3db6ILluHSsb7t46sBKLYX85qp/GnzfAvN8Bf2NkHfkELlagbbAGfLmaz1Zrn2Vl4Zx9L62QO5LTqp1dDyOJtCbKxBoB1fF2AcAK0D7U1dxHR18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726086878; c=relaxed/simple;
	bh=Sf0HrKfuscu/ZVTJ/+eFaQGpUVHZL1lX+Q2olmuuWmM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kL3MckJ711AZ6LNbPzWU+hSYfCPlWg4UKFAqqWOEe5drDr/fe8As5GsmkiR0HD50wGfx+Do+quwpuzWignOL+S4SDgBm1kjYdDucNGFYsVdVmPbcqJRPDSLV824lr5KQE7gBDAi70IkNURDce1zyjFWN9iYSm6DLXK5DC3z3PAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=g1GYA1BV; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 26CA1889E9;
	Wed, 11 Sep 2024 22:34:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1726086875;
	bh=Sf0HrKfuscu/ZVTJ/+eFaQGpUVHZL1lX+Q2olmuuWmM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=g1GYA1BV5bASUOJi0M7Ffbu8KtTS41rjyUClMWVv3OdQ8vs6anBhcXLuXZOwIc/S5
	 aPl8RXhBMG/ivK8hKfM9OYvpcR8MYWGp30hP0btYfQbpEJw7HVifyvvmO58R7bajvc
	 t7045xtr5wACqRURXq7qhgydFwvkiyuaZ8F9p2ToyQAL55xdJ2VD5+xQTOxYdwe0VM
	 0T/ZGoGERLzWToJJ5y8vHMW7UbxugTfv33iHqc9aLSo41Qian3wY8WmNSpYtGh2ove
	 lbc1aZ6fjWlA+FdzjuFkBnpOUbidL0wrSs214myClN/HpYNdLNZTUj+GmtrzB7z5Jh
	 a5duU4kkoeRKw==
Message-ID: <2ede9457-8102-47e4-86dd-5888b6e5b8e6@denx.de>
Date: Wed, 11 Sep 2024 22:28:52 +0200
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] dt-bindings: pwm: imx: Add optional clock '32k'
To: Frank Li <Frank.Li@nxp.com>, =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?=
 <ukleinek@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, pratikmanvar09@gmail.com,
 francesco@dolcini.it, Conor Dooley <conor.dooley@microchip.com>
References: <20240910-pwm-v3-0-fbb047896618@nxp.com>
 <20240910-pwm-v3-1-fbb047896618@nxp.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20240910-pwm-v3-1-fbb047896618@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 9/10/24 9:07 PM, Frank Li wrote:
> The pwm in imx8qxp mipi subsystem require one extra '32k' clock. So
> increase maxItems for clock and clock-names.

This mentions MIPI subsystem, but the IP in question here is PWM.

Are you sure the clock are assigned to the correct IP ?

Shouldn't the clock be assigned to some MIPI IP instead ?

Could you please clarify this in the commit message ?

