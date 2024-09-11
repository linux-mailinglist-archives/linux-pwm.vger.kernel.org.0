Return-Path: <linux-pwm+bounces-3204-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D7AD9975BCD
	for <lists+linux-pwm@lfdr.de>; Wed, 11 Sep 2024 22:34:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B0F028794B
	for <lists+linux-pwm@lfdr.de>; Wed, 11 Sep 2024 20:34:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 345E91BA868;
	Wed, 11 Sep 2024 20:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="eflRnAtY"
X-Original-To: linux-pwm@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ADB01AED22;
	Wed, 11 Sep 2024 20:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726086877; cv=none; b=jVczd5Xhn38tGAvie6DL3mTU/i4U0GG9kCy+Q/nUooFLD1djZMPsHXsqyZqFbVdxd4lDie50M1Pxpbl2a1l39EbpvWegVijvXyng04AK5F2mc7lMVXE/Xoi12Y5RADjXZv5Qi2qZMktva4jD3Zgdh4Vr8h4VdIaIhLfgBRktn90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726086877; c=relaxed/simple;
	bh=suUHOf61RN8aPEjkvGOcwtsJJ+4x4rQmLo9VaWSr8o4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X5bXap9TnGu4E1YO1ZJDq2KRuWevDJ5166viwqFZs1qyVH/AdPutO3CWmju8DqRDNUzdoSkyDpjNGRSShIRGzoRAAxxJuoQDQxpMKM5vqXBOmJ3oIzttOyr0CEkBmTc+rx2v5HcG3XcW4Sd4EtJhbXF+wL2LZYuSdc084NtnP00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=eflRnAtY; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id A583288B14;
	Wed, 11 Sep 2024 22:34:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1726086873;
	bh=suUHOf61RN8aPEjkvGOcwtsJJ+4x4rQmLo9VaWSr8o4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=eflRnAtYbqw8SjnjUdqAyAFMDNJ8atifLFblUVHsrYcvR0xYYBy/naVwspq4wyDEU
	 wMDkqkLtuFUGzFrXM2NP+9pgRKcs//AKcMEpZbKj88RExC0sQ+H57zeGmEuSdn2JlD
	 ch/7ZYEEbwS59ixaDOxIiy/9NxH6B3HF17jzn2xz1+9ZyGg0MSFwUpkwZeaOvSg/FW
	 Mu3MA9mMqkcokGXS0e8aGEh45Wwb51dh8P61CLtouU4Jm4BmN7DLhi6UBt3HBPZw2j
	 6UnSOMQQLFBUizNIg50sH/5zyweZm9DIoRiWakQ6sRn2x2gQ3gISIFnVFmbHbkuwsY
	 pm131YCu+Oj+g==
Message-ID: <82f46096-4053-4bf5-99a7-bc69afd04e38@denx.de>
Date: Wed, 11 Sep 2024 22:27:27 +0200
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/3] pwm: imx: add 32k clock for 8qm/qxp
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
 francesco@dolcini.it, Conor Dooley <conor.dooley@microchip.com>,
 Liu Ying <victor.liu@nxp.com>
References: <20240910-pwm-v3-0-fbb047896618@nxp.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20240910-pwm-v3-0-fbb047896618@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 9/10/24 9:07 PM, Frank Li wrote:

Cover letter should contain some high-level description of the series.

> Signed-off-by: Frank Li <Frank.Li@nxp.com>
[...]

