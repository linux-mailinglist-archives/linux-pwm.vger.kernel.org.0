Return-Path: <linux-pwm+bounces-5187-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EA4A1A60D84
	for <lists+linux-pwm@lfdr.de>; Fri, 14 Mar 2025 10:38:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D32CA3B4071
	for <lists+linux-pwm@lfdr.de>; Fri, 14 Mar 2025 09:38:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74F631EDA14;
	Fri, 14 Mar 2025 09:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PdJjroVH"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEB5C1A8401;
	Fri, 14 Mar 2025 09:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741945110; cv=none; b=KYF7ArhyXLFX4exdFtxHypBv33/DLggutdu8ZuWpoFqcFqHrud3Sspu+AGF3K0vkBKiLD983XXm+no3knjxX/sC/s9y6PNEelLg7IQj3iBkx1mJHq/cNCNr29bybPwBWu54P0G6zM3KNashyvFXmEu9Kz7yF38uKaPAC6ZOKGLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741945110; c=relaxed/simple;
	bh=9JOO7CRqQX9CXeGQfP8hg0Ss7sSzwZk2Cby3Bq+w3T0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fNf6FI2MR14qoqPW2L7TNuOQQAiVQ9aR76Uj9haNe86SlJbgpl5brI/cloLQHHBXNh7AttcskifFCm2NyRRIuZ18EPZMMLqxNxUlv8FvzUDuYEdj+yTmOIFTaHcUrXvfu/JzwX//EPg1733GrM1EEMudSEcxS+zEw4ERabeDhMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PdJjroVH; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-43cfb6e9031so17931145e9.0;
        Fri, 14 Mar 2025 02:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741945107; x=1742549907; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9JOO7CRqQX9CXeGQfP8hg0Ss7sSzwZk2Cby3Bq+w3T0=;
        b=PdJjroVHuW1slySl8Z8rYkDa7tk/4yPJlyW4U+ngI6lz11vSJdXbn82XO0f3i4hYU+
         P//JsEQiz/ED3V0tL9NykfYYIjmSi1ulI0JUd/9ItRHe75+8ehsSMyg6BYeB5NYtlaQv
         Gd6ULSGplIgqFj0lAVNZwNT8uOF56HJ0eb8AEWI3YO6bOe1ws9pip024yMsRpPX+1FEt
         P3FKATEJHtIFKmuC3DnuIZIerG/XCYpJVWMFjX9XIirXnSV5uJv+8QA/m3eIlCIOdv1u
         m/i9v41R+aHx+PKySNuosrC6uPddTCdxZo+v3lHSwy4JlRJovzOooWYrbtapQtQe1faC
         bZkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741945107; x=1742549907;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9JOO7CRqQX9CXeGQfP8hg0Ss7sSzwZk2Cby3Bq+w3T0=;
        b=e9b7QMT0k2HNXmyeCdSET05QC/YcVpienvN589hOpFd8vLwdPD7rg5wbxg+ZupR5qy
         GfRBhDHK2qxTxiMnT4KQE1yDEFcs/xDQDbNjD6536Wiq/YtKPx/nlZ1y+o8J+F62Quj5
         goPup7VtbYIkv4FEAh7vDHUh5imV+Yvf4Yuy1U5ULxlh6CsAanD5e+Q+j8J0xXD5oMAC
         HfijqTMdJ4eF6HP4XGTbP9L6lpIjMjFomTVBQISxkrcCHNr5Ng8mwjTDCJHZGAlnFevt
         4NvnB93VpFtexAXKW62LY4ksgejrSaxwYm/UJ3+gP2PWHihTrFYspgjWQlTvHqr+oR3Q
         MJAw==
X-Forwarded-Encrypted: i=1; AJvYcCUR3tI+Pe+qu8dkEaNotBQsbVi7Vd5di/jy7ool8wKl+GjSEM0Zd7n6XN+ofQrh1ISRxA/o21mCAJaSaGQ=@vger.kernel.org, AJvYcCVE0YZPGFyKppYAhF34oX3T+3yECgLtiJFbpc7aFmcxuCRvFZQNIZER1ajQh3gSMArLdhUTBuRpd8QX@vger.kernel.org, AJvYcCXpXysUJW5vBVCv0aCBUJPQZMzcu2Eb1XsKQewI/tjSj82HpMzVeYiFhNOZKR9LxutgBqGCiZJ1pMqv@vger.kernel.org
X-Gm-Message-State: AOJu0YxxJcum1ZY7rSNN0w3P9ZQYFDiUtPVd8he/z4gDKlpB5Nvzc04Y
	pAvMCjzWBhAVnL1FUkCLuFc1s4ACvRz3fzradpDRvJNnfGst+JtM
X-Gm-Gg: ASbGncvPP5RN98YCrVDSzQwiFA54c/EWQWHr6wwmmJUUw6UBte4eNV7DOnUy3TkkkQ0
	oGHLrOekDYMx91+i6QnUNPcAsUrK1YVlYwplmhWd2LnLZMR72F6zfQTpkBNRY6E+T/ZbdVKncS4
	dDkI0QBxlbEj65XFv7EkKs0cnWrR4Frv4ERJVP6Y/KEnc6LbVpnqrFEM8jPxNY2QpVlZNqdSwLU
	MS+XgFIxGrBFuegdxkm7L46w5gTQcxWsoNxcEIXe/7DfY9N03iFz+rYeXaB0tSiLDpsAM5OwYY/
	qJWyqAt1SJF8QF4kpzyA/nNLSthc6WWLa/ydfKJDga4FeyDV68UT8niO1p40uQjbN3q7xDRTgWD
	Uhv4MG+swgxmmBBgjbBZClcy7jrM=
X-Google-Smtp-Source: AGHT+IHS2EtsS3PUPBUdzMNf6QdwttKulPh2SEXq28olUBTVYVSLPovjP2SGT+iraRKKVJWd6N1I9A==
X-Received: by 2002:a5d:64c9:0:b0:391:2c67:7999 with SMTP id ffacd0b85a97d-39720779405mr2527041f8f.48.1741945106734;
        Fri, 14 Mar 2025 02:38:26 -0700 (PDT)
Received: from ?IPv6:2001:818:ea8e:7f00:2575:914:eedd:620e? ([2001:818:ea8e:7f00:2575:914:eedd:620e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395c8881187sm4892935f8f.41.2025.03.14.02.38.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 02:38:26 -0700 (PDT)
Message-ID: <c59477b2a94cbd10bc530809fbcdc0f2d1b79d07.camel@gmail.com>
Subject: Re: [PATCH 05/18] dt-bindings: mfd: adp5585: document adp5589 I/O
 expander
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, Nuno =?ISO-8859-1?Q?S=E1?=
	 <nuno.sa@analog.com>
Cc: linux-gpio@vger.kernel.org, linux-pwm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-input@vger.kernel.org, Lee Jones
 <lee@kernel.org>,  Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,  Uwe
 =?ISO-8859-1?Q?Kleine-K=F6nig?=	 <ukleinek@kernel.org>, Linus Walleij
 <linus.walleij@linaro.org>, Bartosz Golaszewski <brgl@bgdev.pl>, Dmitry
 Torokhov <dmitry.torokhov@gmail.com>, Laurent Pinchart	
 <laurent.pinchart@ideasonboard.com>, Liu Ying <victor.liu@nxp.com>
Date: Fri, 14 Mar 2025 09:38:32 +0000
In-Reply-To: <20250314-outstanding-futuristic-cat-5d8240@krzk-bin>
References: <20250313-dev-adp5589-fw-v1-0-20e80d4bd4ea@analog.com>
	 <20250313-dev-adp5589-fw-v1-5-20e80d4bd4ea@analog.com>
	 <20250314-outstanding-futuristic-cat-5d8240@krzk-bin>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.54.3 
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

T24gRnJpLCAyMDI1LTAzLTE0IGF0IDA5OjQ5ICswMTAwLCBLcnp5c3p0b2YgS296bG93c2tpIHdy
b3RlOgo+IE9uIFRodSwgTWFyIDEzLCAyMDI1IGF0IDAyOjE5OjIyUE0gKzAwMDAsIE51bm8gU8Oh
IHdyb3RlOgo+ID4gwqDCoCByZWc6Cj4gPiDCoMKgwqDCoCBtYXhJdGVtczogMQo+ID4gQEAgLTYz
LDEzICs3MCwyNiBAQCBhbGxPZjoKPiA+IMKgwqDCoMKgwqDCoCBwcm9wZXJ0aWVzOgo+ID4gwqDC
oMKgwqDCoMKgwqDCoCBncGlvLXJlc2VydmVkLXJhbmdlczogZmFsc2UKPiA+IMKgwqDCoMKgIGVs
c2U6Cj4gPiAtwqDCoMKgwqDCoCBwcm9wZXJ0aWVzOgo+ID4gLcKgwqDCoMKgwqDCoMKgIGdwaW8t
cmVzZXJ2ZWQtcmFuZ2VzOgo+ID4gLcKgwqDCoMKgwqDCoMKgwqDCoCBtYXhJdGVtczogMQo+ID4g
LcKgwqDCoMKgwqDCoMKgwqDCoCBpdGVtczoKPiA+ICvCoMKgwqDCoMKgIGlmOgo+IAo+IERvIG5v
dCBuZXN0IGlmOnRoZW46ZWxzZTppZjp0aGVuLCBpdCBsZWFkcyB0byBjb2RlIGltcG9zc2libGUg
dG8gcmVhZC4KPiBKdXN0IHByb3ZpZGUgaWYtdGhlbiBjYXNlcyBmb3IgZWFjaCBvZiB5b3VyIHZh
cmlhbnQuCj4gCgpBbHJpZ2h0Li4uCgo+IAo+IAo+IAo+ID4gK8KgwqDCoMKgwqDCoMKgIHByb3Bl
cnRpZXM6Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgIGNvbXBhdGlibGU6Cj4gPiArwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCBjb250YWluczoKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBl
bnVtOgo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAtIGFkaSxhZHA1NTg1LTAw
Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIC0gYWRpLGFkcDU1ODUtMDIKPiA+
ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgLSBhZGksYWRwNTU4NS0wMwo+ID4gK8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAtIGFkaSxhZHA1NTg1LTA0Cj4gPiArwqDCoMKg
wqDCoCB0aGVuOgo+ID4gK8KgwqDCoMKgwqDCoMKgIHByb3BlcnRpZXM6Cj4gPiArwqDCoMKgwqDC
oMKgwqDCoMKgIGdwaW8tcmVzZXJ2ZWQtcmFuZ2VzOgo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgbWF4SXRlbXM6IDEKPiAKPiBvbmUgdGVtPwo+IAo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIGl0ZW1zOgo+ID4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIC0gY29uc3Q6IDUKPiA+
IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAtIGNvbnN0OiAxCj4gCj4gQnV0IGhlcmUgdHdv
Li4uCj4gCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaXRlbXM6Cj4gPiArwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIC0gY29uc3Q6IDUKPiA+ICvCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgLSBjb25zdDogMQo+IAo+IGFuZCB0aGlzIGlzIGNvbmZ1c2luZy4gSSBk
b24ndCBnZXQgd2hhdCB5b3Ugd2FudCB0byBleHByZXNzLgo+IAoKSSBqdXN0IGtlcHQgaXQgYXMg
YmVmb3JlIChtYXliZSBJIG1lc3NlZCB1cCBpbiBzb21lIG90aGVyIHdheSBidXQgdGhlIDIgaXRl
bXM6CndlcmUgYWxyZWFkeSBpbiB0aGUgYmluZGluZyk6CgpodHRwczovL2VsaXhpci5ib290bGlu
LmNvbS9saW51eC92Ni4xNC1yYzYvc291cmNlL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5k
aW5ncy9tZmQvYWRpLGFkcDU1ODUueWFtbCNMNzAKCklmIHRoaXMgaXMgbm90IG5lZWRlZCBJIGNh
biBzaW1wbGlmeWluZyBkdXJpbmcgdGhpcyBwYXRjaC4gSXMgdGhpcyBzdWZmaWNpZW50PwoKLi4u
CgogICAgICAgIGdwaW8tcmVzZXJ2ZWQtcmFuZ2VzOgogICAgICAgICAgbWF4SXRlbXM6IDEKICAg
ICAgICAgIGl0ZW1zOgogICAgICAgICAgICAtIGNvbnN0OiA1CiAgICAgICAgICAgIC0gY29uc3Q6
IDEKCgpUaHghCi0gTnVubyBTw6EKCg==


