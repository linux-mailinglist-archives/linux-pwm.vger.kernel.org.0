Return-Path: <linux-pwm+bounces-6563-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 00ECBAEC3BB
	for <lists+linux-pwm@lfdr.de>; Sat, 28 Jun 2025 03:06:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2071F1C43F51
	for <lists+linux-pwm@lfdr.de>; Sat, 28 Jun 2025 01:07:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DA8D1A23B1;
	Sat, 28 Jun 2025 01:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mleia.com header.i=@mleia.com header.b="Gexp/rjx";
	dkim=pass (2048-bit key) header.d=mleia.com header.i=@mleia.com header.b="Gexp/rjx"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail.mleia.com (mleia.com [178.79.152.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DAC52F1FF1;
	Sat, 28 Jun 2025 01:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.79.152.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751072810; cv=none; b=ad296eA+eZAbpZ98u0iHvdOPTPMsVlVL/GF9bpizUzwSWaZtWfezX0J1tXpmuxzsCtFMSvwIB3H5QYi+JFyzAi9SKbgbmyuG3UT2LAid9lXrDo1B/1mYaVZQ5kKQ5R4MIWfIMKX7lYwvTXsTHRWksXc9eZa0WCBCvkmCJp5ZwaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751072810; c=relaxed/simple;
	bh=lvtlGUKgYO9Y0TkSNn7kHB2Oi9ly8/3TM3G1bnzKTDg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IQEEKajFWJ57qB/9yolX4vR8OtvetNlKTjLP84UQ3f/ktZaVLVR7JL7xyTp/tz+q9eKXRIX2Pcywdw3vvtj6f16hHUIzpJL7n9oZeM0unPmUhoGUuzMe8cy2qWPcRfbO7lB08ji+egCu6WKwDodPGjr5pEmOP3ab0OYAZ55nCG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mleia.com; spf=none smtp.mailfrom=mleia.com; dkim=pass (2048-bit key) header.d=mleia.com header.i=@mleia.com header.b=Gexp/rjx; dkim=pass (2048-bit key) header.d=mleia.com header.i=@mleia.com header.b=Gexp/rjx; arc=none smtp.client-ip=178.79.152.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mleia.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mleia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mleia.com; s=mail;
	t=1751072807; bh=lvtlGUKgYO9Y0TkSNn7kHB2Oi9ly8/3TM3G1bnzKTDg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Gexp/rjxeePfASYz5Y/nva3HsYFzNl4QtMlUqPgeoPkp5WoD/uXFGQr84KlvGY/NS
	 X1swoWZrG9UzpBiWx6CfGfuzID1QzOLo3Bon3+oXy1awluqUUjZgtf8bB32fr473zs
	 L4YvExYQ15ifjtPFRPZq4GLBIya5BhD7PWg0ZBCfutjEw/pYWHFPcS7VKek2zCFhum
	 xdn8snRHz6dfX/AMOeedRxwbvGdj03eLcuPP4/pLXinQNrvFu+t/4AQHYyhd7cAN0n
	 YRIs9nOrmhPZRtNEaQLK03CBoh0f8ZjP2oZ0XLwiE+wFrhqGUXsTomx8s0c3HGtJzq
	 KGdyCk8BJg8Ug==
Received: from mail.mleia.com (localhost [127.0.0.1])
	by mail.mleia.com (Postfix) with ESMTP id 9648B3C4FE4;
	Sat, 28 Jun 2025 01:06:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mleia.com; s=mail;
	t=1751072807; bh=lvtlGUKgYO9Y0TkSNn7kHB2Oi9ly8/3TM3G1bnzKTDg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Gexp/rjxeePfASYz5Y/nva3HsYFzNl4QtMlUqPgeoPkp5WoD/uXFGQr84KlvGY/NS
	 X1swoWZrG9UzpBiWx6CfGfuzID1QzOLo3Bon3+oXy1awluqUUjZgtf8bB32fr473zs
	 L4YvExYQ15ifjtPFRPZq4GLBIya5BhD7PWg0ZBCfutjEw/pYWHFPcS7VKek2zCFhum
	 xdn8snRHz6dfX/AMOeedRxwbvGdj03eLcuPP4/pLXinQNrvFu+t/4AQHYyhd7cAN0n
	 YRIs9nOrmhPZRtNEaQLK03CBoh0f8ZjP2oZ0XLwiE+wFrhqGUXsTomx8s0c3HGtJzq
	 KGdyCk8BJg8Ug==
Message-ID: <e541cbf6-7db5-4716-9658-1cac4184ee78@mleia.com>
Date: Sat, 28 Jun 2025 04:06:46 +0300
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] dt-bindings: pwm: convert lpc32xx-pwm.txt to yaml
 format
To: Frank Li <Frank.Li@nxp.com>, =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?=
 <ukleinek@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>,
 "open list:PWM SUBSYSTEM" <linux-pwm@vger.kernel.org>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>,
 "moderated list:ARM/LPC32XX SOC SUPPORT"
 <linux-arm-kernel@lists.infradead.org>,
 open list <linux-kernel@vger.kernel.org>
Cc: imx@lists.linux.dev
References: <20250625161909.2541315-1-Frank.Li@nxp.com>
From: Vladimir Zapolskiy <vz@mleia.com>
In-Reply-To: <20250625161909.2541315-1-Frank.Li@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-49551924 
X-CRM114-CacheID: sfid-20250628_010647_632564_704ED86B 
X-CRM114-Status: UNSURE (   5.57  )
X-CRM114-Notice: Please train this message. 

On 6/25/25 19:19, Frank Li wrote:
> Convert pc32xx-pwm.txt to yaml format.
> 
> Additional changes:
> - add ref to pwm.yaml
> - add clocks
> - restrict #pwm-cells to 3
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Reviewed-by: Vladimir Zapolskiy <vz@mleia.com>

-- 
Best wishes,
Vladimir

