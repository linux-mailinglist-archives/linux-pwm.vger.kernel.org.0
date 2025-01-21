Return-Path: <linux-pwm+bounces-4691-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F835A17B92
	for <lists+linux-pwm@lfdr.de>; Tue, 21 Jan 2025 11:27:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48D393A4141
	for <lists+linux-pwm@lfdr.de>; Tue, 21 Jan 2025 10:26:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60E8B1F1519;
	Tue, 21 Jan 2025 10:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GoBG6TbF"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82CDD1F150C;
	Tue, 21 Jan 2025 10:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737455077; cv=none; b=gI5fgNHjElVVO3nM30ZJsUsJ4yLTcylITZuI1htwzCKGoV/GkM8B3SwHUKPK0DuoqCV7A225SdIjfkbCafwo5VTifxdbCpQtTjCtUB2OfqX6Shl9hz4O24h0YbohGN+rRocD5EMztqVhHO4VvRCPY6/J2sPrl1v0oCxIhAzt3Ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737455077; c=relaxed/simple;
	bh=DblO9dbXP7fC+XLwoXb0zU0r2lydqX+uGvHQ1oAGfu8=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gZf+RE7HXJrKtT551OKp4CBILJSDUGmhZYnPIaGsmwXAlXAPXikM6xzslK8RUeThLXa6Zad7iOFpHIsPlY00wgS/gCXTmufbKs3uf5yPhDqLJ9MDvgs1sFfrW/xvyeDst2GQd24Qn9vua+VNHZ5M6PmhUueJTxUElcRxhXM8H4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GoBG6TbF; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4361f65ca01so55703635e9.1;
        Tue, 21 Jan 2025 02:24:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737455074; x=1738059874; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DblO9dbXP7fC+XLwoXb0zU0r2lydqX+uGvHQ1oAGfu8=;
        b=GoBG6TbFRvFeZGWCLTsIn3LDUbfEfiBO9+7xamUZA8kmvyvznRp3NInRsNQh+5qxuL
         andShiFPkYf52m04M8I07ITh4K57dtF3xyE1uGXX2Q9rA9rsUQDJ67WF543CwyeqMGrs
         2MBxtyNhlscXUSvYWI6mQ2ersuR+yXRtLeVnz/E5JNyR7hmWFKWNNhh5cxStFLBiPUIo
         ViECMnZw0PVRZr2gsKULXmusGMF8S74i7rcHVYrCWCfzS2rcODHk54OOIOC7a0dXYP5c
         OI5/mZL5JfmHTRgvcuDr7nWgKjEHw0qvs4fnMy4AenO1BI9vlkScoseqqGKTr9CZZ+4V
         hjqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737455074; x=1738059874;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DblO9dbXP7fC+XLwoXb0zU0r2lydqX+uGvHQ1oAGfu8=;
        b=wAiw3IreTcl/Jib657YQvUNJlTNwnTLRXpEPnSZYZp3uUIMDpIVmYVbh0fxEaW0JyV
         GDKCa8+Cnl2Pn82J2ZnEkOHDi5rktfawIIpOelURUU9Oc4Ky1tEhLwaX0DRf7wT2NLcx
         t4qgIuwkfaJSxmf2tqQm/UFDRQYqrwM7JyaXD4ZeqzUKR4IC+FV5FU/Ch3gP18Eml/cj
         uBxMslCjcYB3ALt1d7N9c8Koeh2zMrsoJH5Z/2xW8kW0+LQjFZZnmiUs7efdp0Z6H1uy
         FcekQd8mK5XF1rZVzNCyeXZ6lVxcqH8PPHxAIFGDTyBV1t5IQi4aKI8SgNual5nOSOGj
         tytg==
X-Forwarded-Encrypted: i=1; AJvYcCUb3HQ8NBDnI6m7shWFlCsBGuMKphEPGHS+t5uI/cOjBuWh4TN3gh0Q2OCdHr7zFpu4QYAi8w4RrfQu@vger.kernel.org, AJvYcCVE7ZaTByHLI5soQySrhyDvtPeMS7sAjv/baTJOcqaj36NABebYMQelTXljgpRPgAP3wAtcPGCz/ESW@vger.kernel.org, AJvYcCW/ystdEQwd0552/chYehATRtWU7r/Hb/4F8zLYKeEzhA/Atx35H3pVDV6MBOJR/JxIoPy72KdNJgFE@vger.kernel.org, AJvYcCXHnpNqq7tPSqwQOLfa4ew4gIp0TJtUbISK2FHc8AL4oHEEKjDGri6jwsxaD928LCM2C5bB0tTdniO1Fu6e@vger.kernel.org
X-Gm-Message-State: AOJu0Ywje/ze/8ELiKf9jUM76fdk+CqSUSd6eNU1Y7Xv7lY2f0gnyIIa
	5L4wy9mCiQAWMTeTf/XvlnDvVhaz9r6K0AAH2KkzyH7Hg4jQFWUV
X-Gm-Gg: ASbGncsckN52VxzaKzcnfPg65/gAOi/QvXdYjYdAECvcWvbRMDa+0tWZwbyTkljgLjb
	OUc3eNGmTVatLHecg20CcPGurowWyokc5r39fXuVjiSOIYJY5RljQHRKbLhJCbk5PLlPqER16Y5
	T8Nf33j3lDA0Uz2Rb+mURvvJnki1CR34F5Qf9weVmAEeW2zEzCJ3drCgO9KZUXXd7MTILWAz/yp
	O66jvO9kvPEMhORet6+G9NO63c2PkgtRloSG6jlwB3+0EufIEWNNTKEzlWDahoIfoMcsNBIBcM9
	cKmQbJZD7jD6JOPucYdgLcnLJJeOpaaSiMVAg6gfag==
X-Google-Smtp-Source: AGHT+IFnjiMeCtiY/aot+h7dHkwkd/S76quoKt+0+U7SjRu4RdTb8J91aLuqLQnIGlEUMXYKQ/oTUQ==
X-Received: by 2002:a05:600c:c0f:b0:42c:c28c:e477 with SMTP id 5b1f17b1804b1-4389141c0a9mr142689915e9.23.1737455073360;
        Tue, 21 Jan 2025 02:24:33 -0800 (PST)
Received: from ?IPv6:2001:818:ea8e:7f00:2575:914:eedd:620e? ([2001:818:ea8e:7f00:2575:914:eedd:620e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-437c7527fd1sm236234245e9.31.2025.01.21.02.24.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2025 02:24:33 -0800 (PST)
Message-ID: <70975c6682e4eed4ede3d751830813290e6fee80.camel@gmail.com>
Subject: Re: [PATCH v10 8/8] iio: adc: ad4851: add ad485x driver
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: David Lechner <dlechner@baylibre.com>, "Miclaus, Antoniu"
	 <Antoniu.Miclaus@analog.com>, "jic23@kernel.org" <jic23@kernel.org>, 
 "robh@kernel.org"
	 <robh@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>, 
 "linux-iio@vger.kernel.org"
	 <linux-iio@vger.kernel.org>, "devicetree@vger.kernel.org"
	 <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	 <linux-kernel@vger.kernel.org>, "linux-pwm@vger.kernel.org"
	 <linux-pwm@vger.kernel.org>
Date: Tue, 21 Jan 2025 10:24:33 +0000
In-Reply-To: <c424cedb-5b45-43c0-897b-dec83918d658@baylibre.com>
References: <20250117130702.22588-1-antoniu.miclaus@analog.com>
	 <20250117130702.22588-9-antoniu.miclaus@analog.com>
	 <d4b9d6e9-745c-4c35-a62d-18e0a36f30c4@baylibre.com>
	 <BN6PR03MB33953EC70A02D0031373C2BD9BE72@BN6PR03MB3395.namprd03.prod.outlook.com>
	 <c424cedb-5b45-43c0-897b-dec83918d658@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.54.3 
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

T24gTW9uLCAyMDI1LTAxLTIwIGF0IDExOjM3IC0wNjAwLCBEYXZpZCBMZWNobmVyIHdyb3RlOgo+
IE9uIDEvMjAvMjUgNjozNyBBTSwgTWljbGF1cywgQW50b25pdSB3cm90ZToKPiA+ID4gPiArCQl9
Cj4gPiA+ID4gKwkJY2hhbm5lbHMrKzsKPiA+ID4gPiArCj4gPiA+ID4gKwkJc3QtPmJpcG9sYXJf
Y2hbcmVnXSA9IGZ3bm9kZV9wcm9wZXJ0eV9yZWFkX2Jvb2woY2hpbGQsCj4gPiA+ICJiaXBvbGFy
Iik7Cj4gPiA+ID4gKwo+ID4gPiA+ICsJCWlmIChzdC0+Ymlwb2xhcl9jaFtyZWddKSB7Cj4gPiA+
ID4gKwkJCWNoYW5uZWxzLT5zY2FuX3R5cGUuc2lnbiA9ICdzJzsKPiA+ID4gPiArCQl9IGVsc2Ug
ewo+ID4gPiA+ICsJCQlyZXQgPSByZWdtYXBfd3JpdGUoc3QtPnJlZ21hcCwKPiA+ID4gQUQ0ODUx
X1JFR19DSFhfU09GVFNQQU4ocmVnKSwKPiA+ID4gPiArCQkJCQnCoMKgIEFENDg1MV9TT0ZUU1BB
Tl8wVl80MFYpOwo+ID4gPiA+ICsJCQlpZiAocmV0KQo+ID4gPiA+ICsJCQkJcmV0dXJuIHJldDsK
PiA+ID4gPiArCQl9Cj4gPiA+ID4gKwl9Cj4gPiA+ID4gKwo+ID4gPiA+ICsJKmFkNDg1MV9jaGFu
bmVscyA9IGNoYW5uZWxzOwo+ID4gPiAKPiA+ID4gQXQgdGhpcyBwb2ludCwgY2hhbm5lbHMgaXMg
cG9pbnRpbmcgdG8gbWVtb3J5IHdlIGRpZG4ndCBhbGxvY2F0ZSAoYmVjYXVzZQo+ID4gPiBvZgo+
ID4gPiBjaGFubmVscysrKS4gQXMgaW4gdGhlIHByZXZpb3VzIHJldmlldywgSSBzdWdnZXN0IHdl
IGp1c3QgZ2V0IHJpZCBvZiB0aGUKPiA+ID4gb3V0cHV0Cj4gPiA+IHBhcmFtZXRlciBzaW5jZSBp
bmRpb19kZXYtPmNoYW5uZWxzIGFscmVhZHkgaGFzIHRoZSBjb3JyZWN0IHBvaW50ZXIuCj4gPiA+
IAo+ID4gPiBJdCdzIGxlc3MgY2hhbmNlIGZvciBtaXN0YWtlcyBsaWtlIHRoaXMgYW5kIGF2b2lk
cyBuZWVkaW5nIHRvIHByb3ZpZGUgYW4KPiA+ID4gdW51c2VkCj4gPiA+IGFyZyBpbiBhZDQ4NTdf
cGFyc2VfY2hhbm5lbHMoKS4KPiA+IAo+ID4gSG1tLCBob3cgY2FuIEkgdGhlbiBkbyB0aGUgYXNz
aWdubWVudHMgaW4gYGFkNDg1OF9wYXJzZV9jaGFubmVsc2AgPwo+ID4gCj4gPiBkcml2ZXJzL2lp
by9hZGMvYWQ0ODUxLmM6MTA1NTo0MjogZXJyb3I6IGFzc2lnbm1lbnQgb2YgbWVtYmVyCj4gPiDi
gJhoYXNfZXh0X3NjYW5fdHlwZeKAmSBpbiByZWFkLW9ubHkgb2JqZWN0Cj4gPiDCoDEwNTUgfMKg
wqAgaW5kaW9fZGV2LT5jaGFubmVscy0+aGFzX2V4dF9zY2FuX3R5cGUgPSAxOwo+ID4gwqDCoMKg
wqDCoCB8wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBeCj4gPiBkcml2ZXJzL2lpby9hZGMvYWQ0
ODUxLmM6MTA1NzozOTogZXJyb3I6IGFzc2lnbm1lbnQgb2YgbWVtYmVyCj4gPiDigJhleHRfc2Nh
bl90eXBl4oCZIGluIHJlYWQtb25seSBvYmplY3QKPiA+IMKgMTA1NyB8wqDCoMKgIGluZGlvX2Rl
di0+Y2hhbm5lbHMtPmV4dF9zY2FuX3R5cGUgPSBhZDQ4NTFfc2Nhbl90eXBlXzIwX2I7Cj4gPiDC
oMKgwqDCoMKgIHzCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIF4KPiA+IGRyaXZlcnMvaWlvL2FkYy9hZDQ4
NTEuYzoxMDU4OjQzOiBlcnJvcjogYXNzaWdubWVudCBvZiBtZW1iZXIKPiA+IOKAmG51bV9leHRf
c2Nhbl90eXBl4oCZIGluIHJlYWQtb25seSBvYmplY3QKPiA+IMKgMTA1OCB8wqDCoMKgIGluZGlv
X2Rldi0+Y2hhbm5lbHMtPm51bV9leHRfc2Nhbl90eXBlID0KPiA+IEFSUkFZX1NJWkUoYWQ0ODUx
X3NjYW5fdHlwZV8yMF9iKTsKPiA+IMKgwqDCoMKgwqAgfMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCBeCj4gPiBkcml2ZXJzL2lpby9hZGMvYWQ0ODUxLmM6MTA2MTozOTogZXJyb3I6IGFzc2ln
bm1lbnQgb2YgbWVtYmVyCj4gPiDigJhleHRfc2Nhbl90eXBl4oCZIGluIHJlYWQtb25seSBvYmpl
Y3QKPiA+IMKgMTA2MSB8wqDCoMKgIGluZGlvX2Rldi0+Y2hhbm5lbHMtPmV4dF9zY2FuX3R5cGUg
PSBhZDQ4NTFfc2Nhbl90eXBlXzIwX3U7Cj4gPiDCoMKgwqDCoMKgIHzCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIF4KPiA+IGRyaXZlcnMvaWlvL2FkYy9hZDQ4NTEuYzoxMDYyOjQzOiBlcnJvcjogYXNzaWdu
bWVudCBvZiBtZW1iZXIKPiA+IOKAmG51bV9leHRfc2Nhbl90eXBl4oCZIGluIHJlYWQtb25seSBv
YmplY3QKPiA+IMKgMTA2MiB8wqDCoMKgIGluZGlvX2Rldi0+Y2hhbm5lbHMtPm51bV9leHRfc2Nh
bl90eXBlID0KPiA+IEFSUkFZX1NJWkUoYWQ0ODUxX3NjYW5fdHlwZV8yMF91KTsKPiA+IMKgwqDC
oMKgwqAgfMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBeCj4gCj4gSSB3b3VsZCBiZSB0ZW1w
dGVkIHRvIGp1c3Qgbm90IGhhdmUgYSBzZWNvbmQgbG9vcCBvZgo+IAo+IAlkZXZpY2VfZm9yX2Vh
Y2hfY2hpbGRfbm9kZV9zY29wZWQoZGV2LCBjaGlsZCkKPiAKPiBpbiBhZDQ4NThfcGFyc2VfY2hh
bm5lbHMoKSBhbmQgaW5zdGVhZCBkbyBldmVyeXRoaW5nIGluCj4gYWQ0ODUxX3BhcnNlX2NoYW5u
ZWxzKCkKPiBhbmQganVzdCBwYXNzIGEgYm9vbGVhbiBwYXJhbWV0ZXIgdG8gY29uZGl0aW9uYWxs
eSBoYW5kbGUgdGhlIGRpZmZlcmVuY2UKPiBiZXR3ZWVuIHRoZSB0d28gdHlwZXMgb2YgY2hpcHMu
Cj4gCj4gT3IgeW91IHVzZSBhIGNhc3QgdG8gcmVtb3ZlIHRoZSBjb25zdCBxdWFsaWZpZXIuCj4g
Cj4gCWFkNDg1MV9jaGFubmVscyA9IChzdHJ1Y3QgaWlvX2NoYW5fc3BlYyAqKWluZGlvX2Rldi0+
Y2hhbm5lbHM7CgpIbW0gYSBiaXQgbmFzdHkgSU1PIDopLgoKQnV0IHVwIHRvIHlvdSBib3RoIGFu
eXdheXMuLi4KCi0gTnVubyBTw6EgCg==


