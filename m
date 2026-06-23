Return-Path: <linux-pwm+bounces-9357-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id VMgSDRKZOmq9BAgAu9opvQ
	(envelope-from <linux-pwm+bounces-9357-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Tue, 23 Jun 2026 16:32:50 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E3C86B7EC0
	for <lists+linux-pwm@lfdr.de>; Tue, 23 Jun 2026 16:32:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=kQhwOfFK;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9357-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9357-lists+linux-pwm=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4DCFC3008A51
	for <lists+linux-pwm@lfdr.de>; Tue, 23 Jun 2026 14:31:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D03F834E761;
	Tue, 23 Jun 2026 14:31:33 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A17B37DAB3
	for <linux-pwm@vger.kernel.org>; Tue, 23 Jun 2026 14:31:32 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782225093; cv=none; b=iE4fOF24d8LBlpscy3UI+h5Ejh2EIwghZmlww2msuaVxlPcVmVdsBk8AgGd8m6pxS8D63EfLwmYKhDiL6aXEt4zVl6yaTRZ6JrJBaveM3fdxUDz75vLuh964ZB7Y52AJ7Gl+IcKj/REE6IbDRmRHSBpIpYWclvUxz2/MgGX0KYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782225093; c=relaxed/simple;
	bh=jL8ez0Mg8YXopchCfhkbqbjK8n46SxQBwnGjRXDAm3g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JkZ8HK7mJ6FGutQqu/uFOVC9gfl7KFcppKmUwvBd1SRA2hoiAwpNFJS9RA63dUZPi2yoep9AFTSf8/y8ENq8ovW0E+PBmI/bmKIBRqb267DQ5EUeFR+J2HU2/KotZ79xUXrxxAD7u9KUdmtSmVeLNrgLN5wZHJkb+uwpiXTMoaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kQhwOfFK; arc=none smtp.client-ip=209.85.214.181
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2bf1cda2b17so8167665ad.1
        for <linux-pwm@vger.kernel.org>; Tue, 23 Jun 2026 07:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782225092; x=1782829892; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=X+YRmIk4UyV8Qff92WrjW7hCQWfT5q+1RioQVlsR+EQ=;
        b=kQhwOfFKDdB9Ww9lULXXL4sQ4yLJ1bAOYoIO3C6VWycAVFH0AWwoo8usz6+0RH+NJ0
         MrfwAGXQbuhSSMMOLrOijFVwTx5FwXbimRSpmWI8RcQTb/EhLrL21NNWumb6t3rxIRxJ
         X273skj/o4QjEcjOJlsPd+Zb3GYP0VHlCllRe2HTTVadgcnzwJ1PuoAgxT4ZiV9IZze3
         eqEwUE+k+BWLTCcOEhKMcI89qNqMBDmgqSXN3onVR72YfG2nZH60Gy4gl8aHTjhNZGnU
         wNSV0Gss6YjZmLyJxyDV13SdZDLDqSaBqQFyhPMs04esIIRIr5nJRRPNXiVZmTmOFRH/
         L3SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782225092; x=1782829892;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X+YRmIk4UyV8Qff92WrjW7hCQWfT5q+1RioQVlsR+EQ=;
        b=e12PWACQ8fQ3if5m5Nu7REfsJe0iGbWNPRCPljN/FCHUUI68QAGNb6o+nA9avQH9sM
         YqNaRcd+w2IF7aj18dL55+H4ctfAR6jen5TmrdFHDj1VO5RJfHCR4GCEaH93a9CdAvy/
         GhgLizua0zO8SSGvJa0gyPDSGJBYVR2Vak1qMMW/RpN0oFxnJ2cDc0lveoV/Hr5celeR
         VnZBHd4oQerr7zGgPE4AVxUeJTTqI6A0IMoHBffLrogJVHKzslzlzhnpzjmypCgDbHRz
         8sC5QTsFKmg2sTGxs33qVuv+XTxlfjd21MGFsSonJK0Wym8L+HBaxNr6w1zVPbm5uo+h
         z/aw==
X-Forwarded-Encrypted: i=1; AHgh+Rr3VZEj9mtoJGidOPxvN0ucU7b+Sy8LsCbk4zBCjz4HHVeGOhTPmamyLi/XYn1m/BrbqWK/D7QvPy8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUi5afiUFKIWY/x1QY09uiPY9fbW7nORe6/TsJriX7ZZ4cLlVo
	FFIVFo5xcBrsmBJxintIHVPfYMEYri/ZmY55FfmPDz3+f/0AT6ocv/zK
X-Gm-Gg: AfdE7cnuoHC7Wh3e0EhXdLcawmOJZCbTWjWrGkedgwn2YG2w+U8GTASpY9FvB7dzo6t
	K5/bGs7ccb/jbI4LrwdT89+Nk9UfqxX2xrnWQb14Md/j0DWvvs8xejNveaes0HfL8Y8AjnfUvv9
	D7eaZWvq/5OFaslXgoDeI7QPt7h6msJdtJdA1O/HtOIOLOQyPb3JvBWFQAkFzZY3R0RhSdEniiB
	QTeH63LwX9mCeTJryuBNEkgljBupEof0ye/HnqiodUhY2lsFnPaKqrJ35cpmU6uGoA6HYghMhMq
	J1jq/aEgGEYA4QdWY8B+9DGkHYHJHlN+bowDyRwFG+JNpjaVLGu0tu9P50GXmoxaPgs1ldvjoDz
	vrntU6HwPhPobREE8A985iI0sQ7k1o26eAZvyWJUtnYLLcKfOgGs3q4M1OOBhk8mYqETAZM7a0C
	XsF6hpEJS6PmMmF81yiDb1EqQADiYQOMPi8IU=
X-Received: by 2002:a17:903:90d:b0:2c1:41f8:7ef5 with SMTP id d9443c01a7336-2c7c3ff85b9mr33653875ad.22.1782225091819;
        Tue, 23 Jun 2026 07:31:31 -0700 (PDT)
Received: from [192.168.0.2] ([49.207.62.136])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c7444aa5f1sm131772715ad.78.2026.06.23.07.31.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jun 2026 07:31:31 -0700 (PDT)
Message-ID: <9379bfdb-9a9c-4fea-924c-6c1dc8e997c1@gmail.com>
Date: Tue, 23 Jun 2026 20:01:27 +0530
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] dt-bindings: pwm: st,pwm: convert to DT schema
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Pal Singh <ajitpal.singh@st.com>,
 linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260618-st-pwm-v2-1-c792d5795ce2@gmail.com>
 <20260623-electric-adder-of-upgrade-8bdeb4@quoll>
 <464e09d2-5a8f-42ea-998a-42cf1376a6e7@gmail.com>
 <761cb58f-17cd-4a0b-98eb-a38b3b619941@kernel.org>
Content-Language: en-US
From: Charan Pedumuru <charan.pedumuru@gmail.com>
In-Reply-To: <761cb58f-17cd-4a0b-98eb-a38b3b619941@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9357-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:krzk@kernel.org,m:ukleinek@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:ajitpal.singh@st.com,m:linux-pwm@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[charanpedumuru@gmail.com,linux-pwm@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[charanpedumuru@gmail.com,linux-pwm@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7E3C86B7EC0



On 23-06-2026 19:55, Krzysztof Kozlowski wrote:
> On 23/06/2026 16:16, Charan Pedumuru wrote:
>>
>>
>> On 23-06-2026 12:47, Krzysztof Kozlowski wrote:
>>> On Thu, Jun 18, 2026 at 12:42:07PM +0000, Charan Pedumuru wrote:
>>>> +description:
>>>> +  The STiH41x PWM controller supports both PWM output and input capture
>>>> +  functionality. It provides multiple PWM output channels for generating
>>>> +  variable duty-cycle waveforms, and multiple input capture channels for
>>>> +  measuring external signal periods and pulse widths. PWM output channels
>>>> +  and input capture channels are configured independently via
>>>> +  st,pwm-num-chan and st,capture-num-chan respectively.
>>>> +
>>>> +allOf:
>>>> +  - $ref: pwm.yaml#
>>>
>>> Where is this compatible used?
>>
>> I will remove this allof and redefine the YAML again
>>
> 
> 
> Sorry, I think I messed something so comment was incorrectly placed.
> 
> The comment should be under:
> 
> "+    const: st,pwm"

Okay, this compatible is not used and there is a similar compatible "st,sti-pwm", AI bot detected it and I will rename it and modify the commit message with necessary explanation. Also the maintainer email doesn't exist now. I will change that too with other maintainer. Thank you.

> 
> Best regards,
> Krzysztof

-- 
Best Regards,
Charan.


