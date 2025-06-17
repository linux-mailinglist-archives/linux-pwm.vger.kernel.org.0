Return-Path: <linux-pwm+bounces-6395-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D6F0DADC5D1
	for <lists+linux-pwm@lfdr.de>; Tue, 17 Jun 2025 11:10:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A34403B7C53
	for <lists+linux-pwm@lfdr.de>; Tue, 17 Jun 2025 09:09:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B6B02949F3;
	Tue, 17 Jun 2025 09:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="QPw58bue";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="PN2xsj/0"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AE1C293457;
	Tue, 17 Jun 2025 09:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750151345; cv=none; b=vBUR1wa8jKjBZqa/0pzJO09gJQwJAbdqIwRlPHv0YsLBfhJ+umyu0zwRR3iQt5G60RlawuqyyHj8STpgbiC3UkWyg5TrRzMix03b3fYjnyTIiiNn5lB087GFd0V4KCl15/G1rw29bP0HFS5SpgsmEswemOzIxDhApNa/dw4i74Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750151345; c=relaxed/simple;
	bh=SEBaWNsn7j7zIu4K9J7rqzur89jgUy2wbonTIcXXdSM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bOCzR4e7GLSEZ5sNyheQP5A3hmG+IVxxl4NIAtWyIUPdYGpGWBVDOS6oxhp2JDwY9LVAJ+Ij8cCuu989/ZD7ZjWZVjJnZwH/99CQ6lo9MYeeiyAbjJQrmUDOwpVlvwQ28yh+RBGpQZfED+0vYMr4ojdwYNvn7tpzpbEP+Bg1qec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=QPw58bue; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=PN2xsj/0; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4bM1JS31Cvz9tPr;
	Tue, 17 Jun 2025 11:08:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1750151336;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=upW6BwV3K5F69Ugq8iSkj5vSJYqS1QvTVSbv3NhyNso=;
	b=QPw58buefDBlF4Z5bQ96F0QUsKuUcApRM1M25BySRn7f1kfzuT6CeiV64vEFYVhXqqE61F
	35L3vCXnnbHs9OyHBFO8KvzWq9PzY2npoJVcedAlw+nriYIaAPRzWAi/LwEs31/4T3vQ4x
	T5jpmJrIypoAPyaDDci4v6jPek1KmYgBrMCHciGX9JgO6hjbEWQuJWofBZ4rJju4yYWEUn
	KVn0J54FQw1QdliknrKzl3zsWMFB8xbvb1VzIUIgglGyY/+6edv80BTIw0H228tii1B19A
	9uCOgzRyfxxG6o2fCNHQ6XbXGO51JbaKoFXMup0P9gtpt5x7MmuoJd2yLQbpng==
Message-ID: <759de22c-e7b9-4938-b6e9-199e8ac9135e@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1750151334;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=upW6BwV3K5F69Ugq8iSkj5vSJYqS1QvTVSbv3NhyNso=;
	b=PN2xsj/0MdVr3E8TajrwLd8zTYH6J1m37vmIedPPTLk/7SBFtnIvuwmxCKL7Rk3b22/B1j
	Yf8c8/iIzIPRgFosgHDVqihEpOURHPDOU+i/gcOv+j7AgT9ms98XQw0UqmkR3EgMY0U2z0
	r3he8hrn4oe6ea8cPBXLkvh0l00mjWOFl33kjYQlMTrMvneN+Rugluh8ym6Mam0wzgQkfG
	HFsEUer2M5/Z4G5AUGIiaBla+mQNJ5pM+v+iltIdlI8y6HRfiRX3f4KnsOjTMAxPRZPLBT
	I9ieYvcevkoJeN93chCzU8egVhNB2a/UZLj9vkor+a+DJ2WzUwk/7BwlC9F9qQ==
Date: Tue, 17 Jun 2025 11:08:51 +0200
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 2/3] dt-bindings: pwm: argon40,fan-hat: Document
 Argon40 Fan HAT
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: linux-pwm@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>,
 devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org
References: <20250617002852.606409-1-marek.vasut+renesas@mailbox.org>
 <20250617002852.606409-2-marek.vasut+renesas@mailbox.org>
 <ikzvtvoigie7e4ift57zoi2uaygemwisjycs4zvgbiwf5s3mxi@mf6pjf6zujcv>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <ikzvtvoigie7e4ift57zoi2uaygemwisjycs4zvgbiwf5s3mxi@mf6pjf6zujcv>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 3sqga3j67jgdxrgw1ao83xuxrfymke3r
X-MBO-RS-ID: 744d3e6f14c78584c4c
X-Rspamd-Queue-Id: 4bM1JS31Cvz9tPr

On 6/17/25 9:49 AM, Uwe Kleine-König wrote:
> Hello Marek,

Hi,

> On Tue, Jun 17, 2025 at 02:28:01AM +0200, Marek Vasut wrote:
>> Document trivial PWM on Argon40 Fan HAT, which is a RaspberryPi
>> blower fan hat which can be controlled over I2C.
>>
>> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
>> ---
>> Cc: "Uwe Kleine-König" <ukleinek@kernel.org>
>> Cc: Conor Dooley <conor+dt@kernel.org>
>> Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>
>> Cc: Rob Herring <robh@kernel.org>
>> Cc: devicetree@vger.kernel.org
>> Cc: linux-pwm@vger.kernel.org
>> Cc: linux-renesas-soc@vger.kernel.org
>> ---
>> V2: Implement dedicated binding document
>> ---
>>   .../bindings/pwm/argon40,fan-hat.yaml         | 47 +++++++++++++++++++
>>   1 file changed, 47 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/pwm/argon40,fan-hat.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/pwm/argon40,fan-hat.yaml b/Documentation/devicetree/bindings/pwm/argon40,fan-hat.yaml
>> new file mode 100644
>> index 000000000000..2725eee5328c
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/pwm/argon40,fan-hat.yaml
>> @@ -0,0 +1,47 @@
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
>> +  The trivial PWM on Argon40 Fan HAT, which is a RaspberryPi blower fan
>> +  hat which can be controlled over I2C, generates a fixed duty cycle PWM
>> +  signal with configurable period to control the fan speed.
> 
> Did you get that right? I would have expected a fixed period and the
> parameter modifying the duty cycle?
I actually found a fixed 30 kHz period PWM at the underside of the 
device, it wasn't easy to reach. Expect a V3.

