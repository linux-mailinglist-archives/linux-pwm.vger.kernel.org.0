Return-Path: <linux-pwm+bounces-6392-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B4174ADBE2D
	for <lists+linux-pwm@lfdr.de>; Tue, 17 Jun 2025 02:30:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B28EC3B6F0F
	for <lists+linux-pwm@lfdr.de>; Tue, 17 Jun 2025 00:30:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7D5D14A4F0;
	Tue, 17 Jun 2025 00:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="qq+tFno4"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B6065C603;
	Tue, 17 Jun 2025 00:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750120209; cv=none; b=HOCVlQhvf0IwxR14/LWpmrHZoojH+VtuCbsBe5Q62PlpLfEOWTsafT1ukVHEP947btkQES9KLTU2reISAfA7qm0muInEAvaKyI0N35YFwckxxp1jCMwHZT2O27GQpSuzXuVOPTHcoeAMUh0q9wEhyNb4BR0Ijw3O+NZfbqnni98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750120209; c=relaxed/simple;
	bh=LWfWQdMGljJItAwb3Fgg/eGCcbsuAQU4tIAoU1wiQ4s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JvZSEXnxVfGYDttaY/yuVZjXhNsl4MKT2a3rQJdLUVkl5KBbJqrgsfwQjuV894BzW3npvhbNLRyGcUb+CDwGM7WdWw1Mse0tmMQxicktEENq7qFkaSbwKJPWfjyOUkfy9Aqv2gMicqbaAsVX/y6qZ6GDXvCK5+TOTIk/LWbMzOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=qq+tFno4; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4bLnnm54nRz9sGw;
	Tue, 17 Jun 2025 02:30:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1750120204;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nHZJ9Y44AavoDfgyEJ+JqiTM2lakkI1nhZKvDnh4MGU=;
	b=qq+tFno4rSD6AQNqZThQ3VGrddNT63VrTSSTjUCp7EgJgTFY1Uz95+gPYG1SzY5pOcuDFr
	/pRiGm8R1Q0keOmNZIegI+iU27KsXT53EomvkniXpafSGKAXfzvPnov7MljOk5Z6KX7XLD
	ySxlc0qPG5MmFRajIV8FJfSqZm/FpMuB89eZLjWe4/nWYy8awCBAozx2kDVlL8ndjldMYK
	1go29c8DKSZBO64HfdYUObpIvtTONMNkf8RMmYbZ702RsNF7sF4FMgnX5nw5aEGDZV5TbC
	UtVNWDcAD2cFFVsAW7lcZpU6/07/TA382zev9zfTn4xIl+1/olrrVOv0sC17Sw==
Message-ID: <2aa6a582-cd5b-4a82-8dc3-66163250f086@mailbox.org>
Date: Tue, 17 Jun 2025 02:30:02 +0200
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 2/3] dt-bindings: trivial-devices: Document Argon40 Fan
 HAT
To: Conor Dooley <conor@kernel.org>
Cc: linux-pwm@vger.kernel.org, =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?=
 <ukleinek@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>,
 devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org
References: <20250610220814.167318-1-marek.vasut+renesas@mailbox.org>
 <20250610220814.167318-2-marek.vasut+renesas@mailbox.org>
 <20250612-progress-envelope-c332c4cdd26d@spud>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20250612-progress-envelope-c332c4cdd26d@spud>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: 5r669fhubpwedbbmeyjybaa7fysggddm
X-MBO-RS-ID: 82fc0f3e36909ecf33a

On 6/12/25 6:32 PM, Conor Dooley wrote:
> On Wed, Jun 11, 2025 at 12:07:26AM +0200, Marek Vasut wrote:
>> Document trivial PWM on Argon40 Fan HAT, which is a RaspberryPi
>> blower fan hat which can be controlled over I2C.
>>
>> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> 
> I don't see how a pwm controller, with a fan connected to it, is a
> trivial device, sorry.
> PWM fans have their own pwm consumer binding too, so it feels wrong on
> two levels.
Hopefully fixed in V2 series with dedicated bindings, thanks.

