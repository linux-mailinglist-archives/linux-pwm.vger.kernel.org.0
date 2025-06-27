Return-Path: <linux-pwm+bounces-6559-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E00AEAEBC3F
	for <lists+linux-pwm@lfdr.de>; Fri, 27 Jun 2025 17:46:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D89994A40B4
	for <lists+linux-pwm@lfdr.de>; Fri, 27 Jun 2025 15:46:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61F112E8DF9;
	Fri, 27 Jun 2025 15:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KxgewJHQ"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 881B917A317;
	Fri, 27 Jun 2025 15:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751039209; cv=none; b=GsVsSLrFBNiBlboWGkOKoN+sjni0g/CnL6Wa5X8WsuiToPsZrxYYdxwZRQRxGMsf1nHfjLtOGtYErf686WeWnazFCQSzx5HwFkL73T1k1O0IXxG4phLARorRC8YUSMMtc5sQ4vNdPmL0VB41teF76uy+FOqr9Xj7HQdfnDyK+0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751039209; c=relaxed/simple;
	bh=sZs+is19acFLldavf1r3pdZI2nY9d1XTAFsKaQODnns=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=taTrEz3O4qL8Fcm8tiX1qLBR8/P7p6KQlEFxHo19uokswOpsW1HXPA+UEsMlJ8Adt5E920nfo+6uaxHB0ZWcd+7/1ulipCsHWJ/vMOdhTf4sWwhpmOFk/npVNQD7oUCRkjjw/RG8Hheq6UTdv0Mm7y7hhvvwjdPvENxxAqEyWrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KxgewJHQ; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3a4f379662cso1961666f8f.0;
        Fri, 27 Jun 2025 08:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751039206; x=1751644006; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=sZs+is19acFLldavf1r3pdZI2nY9d1XTAFsKaQODnns=;
        b=KxgewJHQc2wheKpfrAq5EqSGpxsfMiUqtb6cUB+cScofoyblQXTdFQ7RDlR51EZxia
         GBB9qcW2vHJ4vaylY2wsE5LKvhrqzu54QOrOmQZioIzaCHsRfTSqB/FAjNRZlMf2pD8H
         ZCj8fmb+SETZmAjN2xYYjaSqQI/uhPzJkO/mVxumE4yJgho702wN8wPQdYYqlIpans1L
         dZVqsakXWh7JJgeU8PSWz64fgXsP2jS/qk9tR2a531SoxctjItPg7SL0TKwhqaBdFQSq
         h4UzxJBcoemywpk1hDDF98wwS6oTa9Z1OOS69ulApvT+ZUMZjz10NKyOvCXl5iAh4R/E
         JWcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751039206; x=1751644006;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sZs+is19acFLldavf1r3pdZI2nY9d1XTAFsKaQODnns=;
        b=DyGMG3vVYdV8Jpg5+aqtMjsPQeqsp2GaNXanSIlujJXpAY0HAWBwe1Ja40qVjPYrut
         NPZZbkwyHNDnvcdg7IMEyyFVpUkAnLuujmG5Wzh824b3Z5ep19OJWPXcEiBfJnRdWT7N
         Gio25MV+HdY2iyT7P+8SlKvMEjNSgrGMjravkjreTQZ4ZZnH/7HRILgqc8EG4/Fushoq
         27XOASta70rnYfwoxBS+fAJ2nnWsXDMzLvM2vTumuOMh9jMcuK72Zdz9XajJUFIrfePz
         Epx0J4NBYROzAyDYFZEam2yI9jQbb8uMTiRh6mSQMKtyV52LN9ExWRnDSd0+MM/afTEm
         4RjA==
X-Forwarded-Encrypted: i=1; AJvYcCVRg47oRiyoZjfFg3ucY30PwwTWRl/EDggjDSiceZCuISyIhKFQU2VvJRn4y4YytqXa+9w1Y/9FxTuA@vger.kernel.org, AJvYcCVXTKvSLsonaTcvrYgrjHrDFS9yx2RI38nhom22sx7UL5cygu9u56q4Hx1n3VJkp+LfADCiTmUrGpKbgGI=@vger.kernel.org, AJvYcCWBWWjkE3OqOEXfzVvYvfQki+H11ELojqjbIm89K/AC0nvZ0UcUZ9dvAShKIQCpxLihMkAD7H14k/E/@vger.kernel.org
X-Gm-Message-State: AOJu0YxAvY53oRBaji3AwRP83A0wweNSjNbJFpc2c1V49LLLcpMvseqv
	mKK//HVznnon9B/sEfY2mcf1doZc6icYgoKu8DLFj+5X9oYBS0YrIvWO
X-Gm-Gg: ASbGnctMjLwlPk/e1VtDrabsBDAN+D9n0Mb74BVNbvIF1e3QIrjr/0GZsXBFZM0b3M2
	AY2mfkpl+6dIdp+5ibV1SruZF8Y1yKcfI4iLVVRYZ0VXkS8QXVPMoz1EybZHnhi298fypeJ2WDE
	2OXLXyZR+jC9XngUM561rKe41cwbAzbBtQ4UFdE8QwoZ8BWn/+36T6gxqqAcPgcDD9bUJJacGtx
	9ocSBMnfKD0hXOre6QglRvJUqZx34dyoFaTVrueRtFuaTox3de4vSE/z8oJ2Y3SnpnrBaiEI9IZ
	LD8VJBIbqL9U0Gz6Aat/iqm3A4JduAsEnIvUnXCk/Iygwy0c9UbWU7Drgdf5zxdNj5twTOFW9eI
	zjYdp
X-Google-Smtp-Source: AGHT+IESHrsctFn3PjEe0RWy9WDHq461r2UviPSd57RHtx666QQl4wyOWgRTySZu5pFX+lAFTakrdA==
X-Received: by 2002:a05:6000:4009:b0:3a4:e502:81e1 with SMTP id ffacd0b85a97d-3a8feb70391mr4311695f8f.52.1751039205499;
        Fri, 27 Jun 2025 08:46:45 -0700 (PDT)
Received: from [192.168.1.187] ([161.230.67.253])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a892e5963csm3019952f8f.79.2025.06.27.08.46.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jun 2025 08:46:45 -0700 (PDT)
Message-ID: <d20682874dbd65acde8b80efa004706a09b23248.camel@gmail.com>
Subject: Re: [PATCH v5 00/20] mfd: adp5585: support keymap events and drop
 legacy Input driver
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Lee Jones <lee@kernel.org>, nuno.sa@analog.com
Cc: linux-gpio@vger.kernel.org, linux-pwm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-input@vger.kernel.org, Rob Herring	
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley	
 <conor+dt@kernel.org>, Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?=
 <ukleinek@kernel.org>,  Linus Walleij <linus.walleij@linaro.org>, Bartosz
 Golaszewski <brgl@bgdev.pl>, Dmitry Torokhov	 <dmitry.torokhov@gmail.com>,
 Laurent Pinchart	 <laurent.pinchart@ideasonboard.com>, Liu Ying
 <victor.liu@nxp.com>, Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Fri, 27 Jun 2025 16:46:54 +0100
In-Reply-To: <20250619133834.GC795775@google.com>
References: <20250614-dev-adp5589-fw-v5-0-7e9d84906268@analog.com>
	 <20250619133834.GC795775@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.56.2 
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

T24gVGh1LCAyMDI1LTA2LTE5IGF0IDE0OjM4ICswMTAwLCBMZWUgSm9uZXMgd3JvdGU6Cj4gT24g
U2F0LCAxNCBKdW4gMjAyNSwgTnVubyBTw6EgdmlhIEI0IFJlbGF5IHdyb3RlOgo+IAo+ID4gSGkg
YWxsLAo+ID4gCj4gPiBIZXJlIGl0IGdvZXMgdjQuIE1haW4gY2hhbmdlcyBpcyB0byBkcm9wIGNo
aXAgaW5mbyBiYXNlZCBzdHJ1Y3QgYW5kCj4gPiBkaXJlY3RseSB1c2UgYW4gZW51bSBpbiB0aGUg
RlcgLmRhdGEgcG9pbnRlciwgdXNlIHRoZSBub3RpZmllciBBUEkgZm9yCj4gPiBkaXNwYXRjaGlu
ZyBldmVudHMgYW5kIG11bHRpcGxlIGNhbGxzIHRvIG1mZF9hZGRfZGV2aWNlcygpLgo+ID4gCj4g
PiBSZWdhcmRpbmcgdGhlIGxhc3QgcG9pbnQsIEkgdGhpbmsgSSBjb3VsZCBoYXZlIHVzZWQgbXVs
dGlwbGUgY2FsbHMgdG8KPiA+IGRldm1fbWZkX2FkZF9kZXZpY2VzKCkgYW5kIGF2b2lkIHRob3Nl
IGdvdG9zIGluIGFkcDU1ODVfYWRkX2RldmljZXMoKQo+ID4gYnV0IEkgZG8gbm90IGZlZWwgdGhh
dCB3b3VsZCBoYXZlIGJlZW4gImNvcnJlY3QiLgo+ID4gCj4gPiBUaGFua3MhCj4gPiAtIE51bm8g
U8OhCj4gPiAKPiA+IC0tLQo+ID4gQ2hhbmdlcyBpbiB2NToKPiAKPiBJbiBmdXR1cmUsIHRoZXNl
IHNob3VsZCBiZSBpbnNpZGUgdGhlIHBhdGNoZXMgdGhlbXNlbHZlcyBwbGVhc2UuCgpIaSBMZWUs
CgpJJ20gYWJvdXQgdG8gc2VuZCB2Ni4gSSBqdXN0IGhhdmUgYSBxdWVzdGlvbiByZWdhcmRpbmcg
dGhlIGFib3ZlLiBEbyB5b3UgbWVhbiB0bwpoYXZlIHRoZSBsb2cgaW4gdGhlIGNvbW1pdCBtZXNz
YWdlIGl0c2VsZiBsaWtlIERSTSBvciBkbyBpdCB3aXRoIGdpdCBub3Rlcz8KCi0gTnVubyBTw6EK
Cj4gCj4gPiAtIFBhdGNoIDI6Cj4gPiDCoCAqIFVzZSB0aGUgZXhpc3RpbmcgZGV2bV9tZmRfYWRk
X2RldmljZXMoKS4KPiA+IC0gUGF0Y2ggMzoKPiA+IMKgICogUmVtb3ZlIFRPRE8gY29tbWVudC4K
PiA+IC0gUGF0Y2ggNDoKPiA+IMKgICogTWVudGlvbiBpbiB0aGUgY29tbWl0IG1lc3NhZ2UgdGhl
IENvcHlyaWdodCB1cGRhdGUuCj4gPiAtIFBhdGNoIDY6Cj4gPiDCoCAqIFJldHVybiBhIHN0cnVj
dCByZWdtYXBfY29uZmlnIHBvaW50ZXIgaW4KPiA+IMKgwqDCoCBhZHA1NTg1X2ZpbGxfcmVnbWFw
X2NvbmZpZygpOwo+ID4gwqAgKiBKdXN0IGxlYXZlIGEgYmxhbmsgZW50cnkgaW4gdGhlIGFkcDU1
ODVfcmVnbWFwX2RlZmF1bHRzIGFycmF5Lgo+ID4gLSBQYXRjaCAxMzoKPiA+IMKgICogSW1wcm92
ZSBjb21tZW50cyBmb3IgcGluNiAocm93NSkgdmFsaWRhdGlvbjsKPiA+IMKgICogRG9uJ3QgdXNl
IG1hZ2ljIG51bWJlcnM7Cj4gPiDCoCAqIERyb3Agc29tZSBvZGQgbGluZSBicmVha3M7Cj4gPiDC
oCAqIEluaXRpYWxpemUgdmFydGlhYmxlIHdoZW4gZGVjbGFyaW5nLgo+ID4gLSBQYXRjaCAxNDoK
PiA+IMKgICogRHJvcCBkb3VibGUgc3BhY2VzOwo+ID4gwqAgKiBEb24ndCB1c2UgbWFnaWMgbnVt
YmVyczsKPiA+IMKgICogSW1wcm92ZSBzb21lIGNvbW1lbnRzLgo+ID4gLSBQYXRjaCAxNjoKPiA+
IMKgICogRml4IG1pc3Npbmcgc2VtaWNvbG9uLgo+ID4gLSBQYXRjaCAyMDoKPiA+IMKgICogRFMg
LT4gZGF0YXNoZWV0LiAKPiA+IAo+ID4gLSBMaW5rIHRvIHY0Ogo+ID4gaHR0cHM6Ly9sb3JlLmtl
cm5lbC5vcmcvci8yMDI1MDUyMS1kZXYtYWRwNTU4OS1mdy12NC0wLWYyYzk4OGQ3YTdhMEBhbmFs
b2cuY29tCj4gPiAtIExpbmsgdG8gdjM6Cj4gPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9yLzIw
MjUwNTEyLWRldi1hZHA1NTg5LWZ3LXYzLTAtMDkyYjE0Yjc5YTg4QGFuYWxvZy5jb20KPiA+IC0g
TGluayB0byB2MjoKPiA+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3IvMjAyNTA0MTUtZGV2LWFk
cDU1ODktZnctdjItMC0zYTc5OWMzZWQ4MTJAYW5hbG9nLmNvbQo+ID4gLSBMaW5rIHRvIHYxOgo+
ID4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvci8yMDI1MDMxMy1kZXYtYWRwNTU4OS1mdy12MS0w
LTIwZTgwZDRiZDRlYUBhbmFsb2cuY29tCj4gPiAKPiA+IC0tLQo+ID4gTnVubyBTw6EgKDIwKToK
PiA+IMKgwqDCoMKgwqAgZHQtYmluZGluZ3M6IG1mZDogYWRwNTU4NTogZWFzZSBvbiB0aGUgcmVx
dWlyZWQgcHJvcGVydGllcwo+ID4gwqDCoMKgwqDCoCBtZmQ6IGFkcDU1ODU6IG9ubHkgYWRkIGRl
dmljZXMgZ2l2ZW4gaW4gRlcKPiA+IMKgwqDCoMKgwqAgbWZkOiBhZHA1NTg1OiBlbmFibGUgb3Nj
aWxhdG9yIGR1cmluZyBwcm9iZQo+ID4gwqDCoMKgwqDCoCBtZmQ6IGFkcDU1ODU6IG1ha2UgdXNl
IG9mIE1GRF9DRUxMX05BTUUoKQo+ID4gwqDCoMKgwqDCoCBkdC1iaW5kaW5nczogbWZkOiBhZHA1
NTg1OiBkb2N1bWVudCBhZHA1NTg5IEkvTyBleHBhbmRlcgo+ID4gwqDCoMKgwqDCoCBtZmQ6IGFk
cDU1ODU6IHJlZmFjdG9yIGhvdyByZWdtYXAgZGVmYXVsdHMgYXJlIGhhbmRsZWQKPiA+IMKgwqDC
oMKgwqAgbWZkOiBhZHA1NTg1OiBhZGQgc3VwcG9ydCBmb3IgYWRwNTU4OQo+ID4gwqDCoMKgwqDC
oCBtZmQ6IGFkcDU1ODU6IGFkZCBhIHBlciBjaGlwIHJlZyBzdHJ1dHVyZQo+ID4gwqDCoMKgwqDC
oCBncGlvOiBhZHA1NTg1OiBhZGQgc3VwcG9ydCBmb3IgdGhlIGFkcDU1ODkgZXhwYW5kZXIKPiA+
IMKgwqDCoMKgwqAgcHdtOiBhZHA1NTg1OiBhZGQgc3VwcG9ydCBmb3IgYWRwNTU4OQo+ID4gwqDC
oMKgwqDCoCBkdC1iaW5kaW5nczogbWZkOiBhZHA1NTg1OiBhZGQgcHJvcGVydGllcyBmb3IgaW5w
dXQgZXZlbnRzCj4gPiDCoMKgwqDCoMKgIG1mZDogYWRwNTU4NTogYWRkIHN1cHBvcnQgZm9yIGV2
ZW50IGhhbmRsaW5nCj4gPiDCoMKgwqDCoMKgIG1mZDogYWRwNTU4NTogc3VwcG9ydCByZXNldCBh
bmQgdW5sb2NrIGV2ZW50cwo+ID4gwqDCoMKgwqDCoCBtZmQ6IGFkcDU1ODU6IGFkZCBzdXBwb3J0
IGZvciBpbnB1dCBkZXZpY2VzCj4gPiDCoMKgwqDCoMKgIGdwaW86IGFkcDU1ODU6IHN1cHBvcnQg
Z3BpIGV2ZW50cwo+ID4gwqDCoMKgwqDCoCBJbnB1dDogYWRwNTU4NTogQWRkIEFuYWxvZyBEZXZp
Y2VzIEFEUDU1ODUvODkgc3VwcG9ydAo+ID4gwqDCoMKgwqDCoCBJbnB1dDogYWRwNTU4OTogcmVt
b3ZlIHRoZSBkcml2ZXIKPiA+IMKgwqDCoMKgwqAgbWZkOiBhZHA1NTg1OiBzdXBwb3J0IGdldHRp
bmcgdmRkIHJlZ3VsYXRvcgo+ID4gwqDCoMKgwqDCoCBkdC1iaW5kaW5nczogbWZkOiBhZHA1NTg1
OiBkb2N1bWVudCByZXNldCBncGlvCj4gPiDCoMKgwqDCoMKgIG1mZDogYWRwNTU4NTogYWRkIHN1
cHBvcnQgZm9yIGEgcmVzZXQgcGluCj4gPiAKPiA+IMKgLi4uL2RldmljZXRyZWUvYmluZGluZ3Mv
bWZkL2FkaSxhZHA1NTg1LnlhbWzCoMKgwqDCoMKgwqAgfMKgIDI0MCArKysrLQo+ID4gwqAuLi4v
ZGV2aWNldHJlZS9iaW5kaW5ncy90cml2aWFsLWRldmljZXMueWFtbMKgwqDCoMKgwqDCoCB8wqDC
oMKgIDIgLQo+ID4gwqBNQUlOVEFJTkVSU8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqDCoMKgIDEg
Kwo+ID4gwqBkcml2ZXJzL2dwaW8vS2NvbmZpZ8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqDCoMKgIDEgKwo+ID4gwqBkcml2ZXJz
L2dwaW8vZ3Bpby1hZHA1NTg1LmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIHzCoCAzNjQgKysrKysrLQo+ID4gwqBkcml2ZXJzL2lucHV0L2tleWJvYXJkL0tj
b25maWfCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoMKgIDIxICst
Cj4gPiDCoGRyaXZlcnMvaW5wdXQva2V5Ym9hcmQvTWFrZWZpbGXCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCB8wqDCoMKgIDIgKy0KPiA+IMKgZHJpdmVycy9pbnB1dC9rZXli
b2FyZC9hZHA1NTg1LWtleXMuY8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoCAzNzEgKysr
KysrKwo+ID4gwqBkcml2ZXJzL2lucHV0L2tleWJvYXJkL2FkcDU1ODkta2V5cy5jwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgfCAxMDY2IC0tLS0tLS0tLS0tLS0tLS0tCj4gPiAtLS0KPiA+IMKg
ZHJpdmVycy9tZmQvYWRwNTU4NS5jwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqAgNzQzICsrKysrKysrKysrKystCj4gPiDCoGRyaXZl
cnMvcHdtL3B3bS1hZHA1NTg1LmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCB8wqDCoCA3OCArLQo+ID4gwqBpbmNsdWRlL2xpbnV4L21mZC9hZHA1NTg1
LmjCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoCAxMTgg
KystCj4gPiDCoDEyIGZpbGVzIGNoYW5nZWQsIDE3OTkgaW5zZXJ0aW9ucygrKSwgMTIwOCBkZWxl
dGlvbnMoLSkKPiA+IC0tLQo+ID4gYmFzZS1jb21taXQ6IDQwN2Y2MGExNTFkZjNjNDQzOTdlNWFm
YzAxMTFlYjliMDI2YzM4ZDMKPiA+IGNoYW5nZS1pZDogMjAyNTAzMTEtZGV2LWFkcDU1ODktZnct
ZTA0Y2ZkOTQ1Mjg2Cj4gPiAtLQo+ID4gCj4gPiBUaGFua3MhCj4gPiAtIE51bm8gU8OhCj4gPiAK
PiA+IAo=


