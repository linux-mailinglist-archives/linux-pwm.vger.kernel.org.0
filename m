Return-Path: <linux-pwm+bounces-8572-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mLXEEBes3WnZhgkAu9opvQ
	(envelope-from <linux-pwm+bounces-8572-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Tue, 14 Apr 2026 04:53:11 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B7C43F51A7
	for <lists+linux-pwm@lfdr.de>; Tue, 14 Apr 2026 04:53:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 47BE83011506
	for <lists+linux-pwm@lfdr.de>; Tue, 14 Apr 2026 02:53:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DECE273816;
	Tue, 14 Apr 2026 02:53:05 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [52.229.168.213])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FB072253FC;
	Tue, 14 Apr 2026 02:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.229.168.213
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776135185; cv=none; b=CVifa7as7Vy1xM5aU7inMH3asn7bccpFlYUmmIE8N4DHzvX8FNn64YB0JmaubH4WjQ39obbtcfDScLagkmrazs2euqJ7dRp/nYh/rtCfACoAMFOMs2fQutmVaxx5P8htsoV/V8uyA5bITsou4iFJzhtG7vinmV/zFZoJGvl5e94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776135185; c=relaxed/simple;
	bh=FNct4cXsb/prTNGqt6dRRBdSJb30gBs9OxLmMeG+EGE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=X07WagNw0oW/jaKbEJYjQLAn0AbIcyEpO/ALaUW+AbPwBMzZCd1oMMhZNOtdLIH3lF6Wu5YLFHerIBKc0JCOaMEFCPsx0jwAhcjacOD6aA8qj6xRG7T/KCIROseRAIbD07Yy7Jt3lRCcq1FSpDzViQpu/AGdJGTj4Bd1xLz0lWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com; spf=pass smtp.mailfrom=eswincomputing.com; arc=none smtp.client-ip=52.229.168.213
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eswincomputing.com
Received: from dongxuyang$eswincomputing.com ( [10.12.96.41] ) by
 ajax-webmail-app2 (Coremail) ; Tue, 14 Apr 2026 10:52:38 +0800 (GMT+08:00)
Date: Tue, 14 Apr 2026 10:52:38 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: "Xuyang Dong" <dongxuyang@eswincomputing.com>
To: "Krzysztof Kozlowski" <krzk@kernel.org>
Cc: ukleinek@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, ben-linux@fluff.org, ben.dooks@codethink.co.uk,
	p.zabel@pengutronix.de, linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	ningyu@eswincomputing.com, linmin@eswincomputing.com,
	xuxiang@eswincomputing.com, wangguosheng@eswincomputing.com,
	pinkesh.vaghela@einfochips.com
Subject: Re: Re: [PATCH v3 1/2] dt-bindings: pwm: dwc: add reset optional
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2024.2-cmXT6 build
 20241203(6b039d88) Copyright (c) 2002-2026 www.mailtech.cn
 mispb-72143050-eaf5-4703-89e0-86624513b4ce-eswincomputing.com
In-Reply-To: <20260403-glossy-industrious-pug-4f2b2c@quoll>
References: <20260402091718.1608-1-dongxuyang@eswincomputing.com>
 <20260402091854.1666-1-dongxuyang@eswincomputing.com>
 <20260403-glossy-industrious-pug-4f2b2c@quoll>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <23dd507b.5335.19d89e7b99c.Coremail.dongxuyang@eswincomputing.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:TQJkCgAnPqH2q91pRoARAA--.3935W
X-CM-SenderInfo: pgrqw5xx1d0w46hv4xpqfrz1xxwl0woofrz/1tbiAQERAmndGpgNU
	gABs7
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
	CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
	daVFxhVjvjDU=
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	DMARC_NA(0.00)[eswincomputing.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-8572-lists,linux-pwm=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dongxuyang@eswincomputing.com,linux-pwm@vger.kernel.org];
	HAS_X_PRIO_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	R_DKIM_NA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[eswincomputing.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4B7C43F51A7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

PiA+IAo+ID4gVGhlIERlc2lnbldhcmUgUFdNIGNvbnRyb2xsZXIgcHJvdmlkZXMgc2VwYXJhdGUg
cmVzZXQgc2lnbmFscyBmb3IgZWFjaAo+IAo+IFNvIG9uZSBjb250cm9sbGVyIGhhcyBzaWduYWxz
LiBQbHVyYWwsIHJpZ2h0PyBUaGVuIHdoeSBkbyB5b3UgZGVmaW5lCj4gb25seSBvbmUgcmVzZXQg
c2lnbmFsPwo+IAoKSGkgS3J6eXN6dG9mLAoKVGhlcmUgYXJlIHR3byByZXNldCBzaWduYWxzwqBt
YXRjaGluZ8KgdGhlIHR3byBjbG9ja3MsIHNvwqBtYXhJdGVtc8KgaXMgc2V0IHRvIDIuCgo+ID4g
Y2xvY2sgZG9tYWluLCBhcyBzcGVjaWZpZWQgaW4gdGhlIGhhcmR3YXJlIGRvY3VtZW50YXRpb24u
IFdpdGhvdXQKPiA+IGFzc2VydGluZyBhbmQgZGVhc3NlcnRpbmcgdGhlc2UgcmVzZXRzIGR1cmlu
ZyBwcm9iZSwgUFdNIG91dHB1dHMgbWF5Cj4gPiByZW1haW4gaW4gYW4gdW5kZWZpbmVkIHN0YXRl
IGFmdGVyIHN5c3RlbSByZWJvb3QuCj4gPiAKPiA+IFRvIGFkZHJlc3MgdGhpcywgdGhlIGRyaXZl
ciBub3cgc3VwcG9ydHMgYW4gb3B0aW9uYWwgJ3Jlc2V0cycgcHJvcGVydHkuCj4gCj4gVGhpcyBp
cyBiaW5kaW5nIGNoYW5nZSwgbm90IGRyaXZlci4KPiAKPiA+IEEgZnVsbCByZXNldCBpcyBwZXJm
b3JtZWQgb25seSB3aGVuIG5vIFBXTSBjaGFubmVsIGlzIGVuYWJsZWQsIGFzCj4gPiBkZXRlcm1p
bmVkIGJ5IHJlYWRpbmcgdGhlIGVuYWJsZSBiaXQgaW4gZWFjaCBjaGFubmVsJ3MgY29udHJvbCBy
ZWdpc3Rlci4KPiAKPiBEbyB5b3UgZGVzY3JpYmUgaGFyZHdhcmUgb3IgZHJpdmVyIGJlaGF2aW9y
PyBUaGlzIGlzIG5vdCBhIGNoYW5nZSBhYm91dAo+IGRyaXZlci4gRGVzY3JpYmUgdGhlIGhhcmR3
YXJlIGhlcmUgLSB3aGF0IGlzIGV4cGVjdGVkIHdpdGggdGhhdCByZXNldC4KPiAKPiA+IFRoaXMg
YWxsb3dzIHNhZmUgY29leGlzdGVuY2Ugd2l0aCBib290bG9hZGVycyB0aGF0IGhhdmUgYWxyZWFk
eQo+ID4gY29uZmlndXJlZCBhY3RpdmUgUFdNIGNoYW5uZWxzLgo+IAoKVGhlIGltcHJvdmVtZW50
IGNvbW1pdCBtZXNzYWdlIGZvciB0aGUgbmV4dCB2ZXJzaW9uIHdpbGwgYmUgcmV2aXNlZCAKYXMg
Zm9sbG93czoKClRoZSBEZXNpZ25XYXJlIFBXTSBpbmNsdWRlcyBzZXBhcmF0ZSByZXNldCBzaWdu
YWxzIGRlZGljYXRlZCB0byBlYWNoIGNsb2NrwqAKZG9tYWluOgpUaGUgcHJlc2V0biBzaWduYWwg
cmVzZXRzIGxvZ2ljIGluIHBjbGsgZG9tYWluLgpUaGUgdGltZXJfTl9yZXNldG4gc2lnbmFsIHJl
c2V0cyBsb2dpYyBpbiB0aGUgdGltZXJfTl9jbGsgZG9tYWluLgpUaGUgcmVzZXRzIGFyZSBhY3Rp
dmUtbG93LgoKSW4gdGhlIG5leHQgdmVyc2lvbiwgd2Ugd2lsbMKgYWRkcmVzc8KgdGhlIGNoYW5n
ZXMgYXMgZGVzY3JpYmVkIGFib3ZlLgoKQmVzdCByZWdhcmRzLApYdXlhbmcgRG9uZwo=

