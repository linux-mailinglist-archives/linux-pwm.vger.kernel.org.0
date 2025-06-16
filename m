Return-Path: <linux-pwm+bounces-6382-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B52E1ADB4E9
	for <lists+linux-pwm@lfdr.de>; Mon, 16 Jun 2025 17:08:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B770D3A57EA
	for <lists+linux-pwm@lfdr.de>; Mon, 16 Jun 2025 15:06:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5837821ABC9;
	Mon, 16 Jun 2025 15:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mleia.com header.i=@mleia.com header.b="WbBmTbcd";
	dkim=pass (2048-bit key) header.d=mleia.com header.i=@mleia.com header.b="WbBmTbcd"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail.mleia.com (mleia.com [178.79.152.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F98520DD42;
	Mon, 16 Jun 2025 15:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.79.152.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750086388; cv=none; b=FSefo2eaX/gFTPHrpzj4Jiv+ZUcxv6ApbbmR+qgWFm6QsRzBjq8qpbWSd/T0ecpO3zxfsWIOEJZTyn7Vjq9y0IQrwLBWwIBUcFpGJGZ1cm75coMT/Rrk9hNp6I61J1v+2NQT0frj7BNNreogcKuZ1ZUQf7JD4htby5GOVoarbFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750086388; c=relaxed/simple;
	bh=xPgwSwP6jtY4uc3j2kc5UG0vwo0IG7i0i/gjdu+S21U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Hj9amZhJrwIgt0qTFJbu1o00Bztgpnx4PGuDPwTiXoGfubKerPJl9MiTrxYuRZ+I0RmHe+RKlXOhGLuPZ7JjLDn085PYKwqLp1Jpkvjytv8qDa9vtLIlK6VKDpET8In7n+qe9FNEiI7hj8RifOPbPVJ9F5bxAMy0jmg/IEniuh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mleia.com; spf=none smtp.mailfrom=mleia.com; dkim=pass (2048-bit key) header.d=mleia.com header.i=@mleia.com header.b=WbBmTbcd; dkim=pass (2048-bit key) header.d=mleia.com header.i=@mleia.com header.b=WbBmTbcd; arc=none smtp.client-ip=178.79.152.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mleia.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mleia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mleia.com; s=mail;
	t=1750086379; bh=xPgwSwP6jtY4uc3j2kc5UG0vwo0IG7i0i/gjdu+S21U=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=WbBmTbcd35Hlq7cXPcLX6KsUQYMGOZye5LrUAutVfBNKlRPrQY+DdLqlEoKahfyeX
	 tFFb+kpyU68Ix5CImaepmmt6+OrdWLCluKF8p/yAlHN4qUyatsCIV+zpyYYEFukteT
	 UkoqUz0k3M9MzQyPHSjyU4+2QJQr2ZGnyb2fNoMJwPi6UQpd6cERLbIBSJ8XPZJoEU
	 ukZuzr07csyraviiUJWrNueOdeJBhYudCY+IGKmGyDTZKp3GkdHMhgYwGf2Zsjb3dJ
	 EH7fI6sDStRQb/7dlYHMwcHF/cOKSkekhjRjxMBvCxaMLQVGNUfGmiTq9qVawJFMEX
	 uMKmVZObqfxxg==
Received: from mail.mleia.com (localhost [127.0.0.1])
	by mail.mleia.com (Postfix) with ESMTP id 5C0433C2957;
	Mon, 16 Jun 2025 15:06:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mleia.com; s=mail;
	t=1750086379; bh=xPgwSwP6jtY4uc3j2kc5UG0vwo0IG7i0i/gjdu+S21U=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=WbBmTbcd35Hlq7cXPcLX6KsUQYMGOZye5LrUAutVfBNKlRPrQY+DdLqlEoKahfyeX
	 tFFb+kpyU68Ix5CImaepmmt6+OrdWLCluKF8p/yAlHN4qUyatsCIV+zpyYYEFukteT
	 UkoqUz0k3M9MzQyPHSjyU4+2QJQr2ZGnyb2fNoMJwPi6UQpd6cERLbIBSJ8XPZJoEU
	 ukZuzr07csyraviiUJWrNueOdeJBhYudCY+IGKmGyDTZKp3GkdHMhgYwGf2Zsjb3dJ
	 EH7fI6sDStRQb/7dlYHMwcHF/cOKSkekhjRjxMBvCxaMLQVGNUfGmiTq9qVawJFMEX
	 uMKmVZObqfxxg==
Message-ID: <3dbd05d1-81be-4f08-8be8-6183bc58a1ee@mleia.com>
Date: Mon, 16 Jun 2025 18:06:17 +0300
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] dt-bindings: pwm: convert lpc1850-sct-pwm.txt to yaml
 format
Content-Language: ru-RU
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
 Frank Li <Frank.Li@nxp.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 "open list:PWM SUBSYSTEM" <linux-pwm@vger.kernel.org>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>,
 imx@lists.linux.dev
References: <20250602140722.941002-1-Frank.Li@nxp.com>
 <hzcpjqvc7jygzt2xj25y7467b55gjv5w6bhgqq7plvzsom44wr@hzfzf6gth2we>
From: Vladimir Zapolskiy <vz@mleia.com>
In-Reply-To: <hzcpjqvc7jygzt2xj25y7467b55gjv5w6bhgqq7plvzsom44wr@hzfzf6gth2we>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-49551924 
X-CRM114-CacheID: sfid-20250616_150619_393596_326E87EE 
X-CRM114-Status: UNSURE (   6.98  )
X-CRM114-Notice: Please train this message. 

On 6/16/25 16:40, Uwe Kleine-König wrote:
> Hello Frank,
> 
> On Mon, Jun 02, 2025 at 10:07:21AM -0400, Frank Li wrote:
>> +properties:
>> +  compatible:
>> +    const: nxp,lpc1850-sct-pwm
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  clocks:
>> +    maxItems: 1
>> +
>> +  clock-names:
>> +    items:
>> +      - const: pwm
>> +
>> +  resets:
>> +    maxItems: 1
> 
> Please add:
> 
>    '#pwm-cells':
>      const: 3
> 
> Otherwise looks fine.
> 

With the requested change applied, please add

Reviewed-by: Vladimir Zapolskiy <vz@mleia.com>

--
Best wishes,
Vladimir

