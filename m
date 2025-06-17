Return-Path: <linux-pwm+bounces-6403-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84266ADCE46
	for <lists+linux-pwm@lfdr.de>; Tue, 17 Jun 2025 15:53:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6E843B4DB5
	for <lists+linux-pwm@lfdr.de>; Tue, 17 Jun 2025 13:49:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4E3F2E6D33;
	Tue, 17 Jun 2025 13:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="YR1APQXH";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="EEFy69h/"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2D982E266C;
	Tue, 17 Jun 2025 13:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750168107; cv=none; b=C72kFLkZsyrchbNZaV8sn/wogI80mXzHw+wxCA70K7z3f+TIW1EQ0A34X21vI7e1r2ag6PHTZwbk0gm4epFpn3v7X0zWp2FsGwN91qjKxgJ/ubChCiVE0qG4Bc2x3mvx+iCLB068lJcjpMOtczi0RC2fUa1dOxqvK2PGeukvmRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750168107; c=relaxed/simple;
	bh=wiws6Qaja8X1qNEjGaJBYuW6EgiAvsI/Llg/tKoPxRA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D6BYIriRhKWoRPXjfYPcO8HJ+zemceTfRyBZrN+PdAlhq3zyjgqctmQpGhpg/kEa1nknFe+jjIcPsNi5KFDvBYNbwy4gPNIj67yuoL3KHh1/tHrAXvMnryP9kSbtxI8l+TCxsufeqe6muMsFZJr9RiVwGlzsToSCjoRUtJk+3o8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=YR1APQXH; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=EEFy69h/; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4bM7Vp10B5z9sxK;
	Tue, 17 Jun 2025 15:48:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1750168098;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=28480iRiD2DiK7+l0ougqeAbzPAdy3FYtcPpLg+iQ/U=;
	b=YR1APQXHSPoA87bVSe7176AQmJZCTx7e67nH1o1+Ki0kzO5o0L8ncV/DgrT+CTH7mDLbjq
	cDumIEOjyIFRp7LXN+XbRTbFlZ0i8yAeOoaEbwO41I3hLgodq/VIQfYe/8dHG55q0+QsSV
	rm+kSgijL4w6ncnxfEX1aTtnJx/Ec8hCA+cJzpebXylsEklCzeqFczE7uAsnD+vUGUKM4N
	JUhE9i5pkEQE8Hf5CGs9dVZqjIbOCF7LchlrcxKJmrjuh5fvZuJFgNtz2WkETz5zHt4fh5
	+rUk4ddGqxuszLPfcsNDp6wWz+ueRFgACUDi1P9g/q9RrMapkkzm9WneRWZZxQ==
Message-ID: <2e152214-5f2d-451c-8659-941184cd8fdd@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1750168095;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=28480iRiD2DiK7+l0ougqeAbzPAdy3FYtcPpLg+iQ/U=;
	b=EEFy69h/jzJcT2LqxSCOrB8TwmP7kXnW8vH+5pyOWSPwHSrJd8lSvVuedifRv6QpFPR7xK
	bUpfVThL6kixuqxZHz7mQfOmoSx5DasMxZZhPuu2r2pGVZzC8YYPOfVcvs2yQ7+zsdvjFd
	MM9f98Z3RE1EXZDGWNd/nvFBwZkLi9WNuyI/kyY4jNXaVKAgsyhzdm/UraN6eYCybfypqj
	zgSPxNA8T5QP3092xtkUyq6QAxUd39uZZ54sPngPdLgD+7btlMYYFr39TXaQi93R+FrKXK
	Thco+PsRpgHQEg10F7EnD+REmFdOBXhjwOWWsi2DOG97u14ks9xXZDBEojDLFg==
Date: Tue, 17 Jun 2025 15:48:13 +0200
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v3 2/3] dt-bindings: pwm: argon40,fan-hat: Document
 Argon40 Fan HAT
To: Rob Herring <robh@kernel.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: linux-pwm@vger.kernel.org, =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?=
 <ukleinek@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, devicetree@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org
References: <20250617092037.37229-1-marek.vasut+renesas@mailbox.org>
 <20250617092037.37229-2-marek.vasut+renesas@mailbox.org>
 <20250617133744.GA1888765-robh@kernel.org>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20250617133744.GA1888765-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: 19ud1dzt3j9i63whngikdsipgjbabbii
X-MBO-RS-ID: 7de417b6fb1811c835b

On 6/17/25 3:37 PM, Rob Herring wrote:

[...]

>> +++ b/Documentation/devicetree/bindings/pwm/argon40,fan-hat.yaml
>> @@ -0,0 +1,48 @@
>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/pwm/argon40,fan-hat.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Argon40 Fan HAT PWM controller
>> +
>> +maintainers:
>> +  - Marek Vasut <marek.vasut+renesas@mailbox.org>
>> +
>> +description: |
> 
> Don't need '|'.

Fixed in V4 ...

>> +      pwm@1a {
>> +        compatible = "argon40,fan-hat";
>> +        reg = <0x1a>;
>> +        #pwm-cells = <2>;
... and also this one, detected by the bot, thanks.

