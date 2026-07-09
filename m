Return-Path: <linux-pwm+bounces-9650-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id t+G/HbT3TmrhXwIAu9opvQ
	(envelope-from <linux-pwm+bounces-9650-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Thu, 09 Jul 2026 03:21:56 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D28DC72BA7C
	for <lists+linux-pwm@lfdr.de>; Thu, 09 Jul 2026 03:21:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9650-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9650-lists+linux-pwm=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 20D6B3006B55
	for <lists+linux-pwm@lfdr.de>; Thu,  9 Jul 2026 01:21:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA8D838B7B4;
	Thu,  9 Jul 2026 01:21:23 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from zg8tmja5ljk3lje4mi4ymjia.icoremail.net (zg8tmja5ljk3lje4mi4ymjia.icoremail.net [209.97.182.222])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2D131B4223;
	Thu,  9 Jul 2026 01:21:20 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783560083; cv=none; b=tpXbcVjDm3dPKY/iVyaIcRSrlV8oT3dKY0bYc2tqV6VEWO3+YcrgVKKOasE5ognBwZXt+9G5aHLp4ydln6LQE0MvFUpnv8rfvyxvkkNaSH9vjL3KD8CAgKQz6aG5oiDHgAsItzp3+hTrJyN1D3BJAKZbgPWj5hWgHCMI8nTZ9T4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783560083; c=relaxed/simple;
	bh=6TrxWkbaxN0/bZBlsK9YOj23oJ+KR30cjtgITH92HIs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=ejBwYiWS/rYvoKs/4cxzhUAmZ9bwJdI+I7ik/rAs7udqLaMSgOVJ3lTzfOLrLBZyhojURpmvfpLO/he/cZv75j7J0EpaBcvzdYh9bkv06QAkwDhmprGv183zZdn3/eDtWvascMf9mFUmwhtxBJ0poq2eW9r/GwQBwdMRbUpL0fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com; spf=pass smtp.mailfrom=eswincomputing.com; arc=none smtp.client-ip=209.97.182.222
Received: from dongxuyang$eswincomputing.com ( [10.12.96.41] ) by
 ajax-webmail-app2 (Coremail) ; Thu, 9 Jul 2026 09:21:08 +0800 (GMT+08:00)
Date: Thu, 9 Jul 2026 09:21:08 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: "Xuyang Dong" <dongxuyang@eswincomputing.com>
To: sashiko-reviews@lists.linux.dev
Cc: ukleinek@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, ben-linux@fluff.org, ben.dooks@codethink.co.uk,
	p.zabel@pengutronix.de, linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	ningyu@eswincomputing.com, linmin@eswincomputing.com,
	xuxiang@eswincomputing.com, wangguosheng@eswincomputing.com,
	pinkesh.vaghela@einfochips.com
Subject: Re: Re: [PATCH v10 3/3] pwm: dwc: add of/platform support
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2024.2-cmXT6 build
 20241203(6b039d88) Copyright (c) 2002-2026 www.mailtech.cn
 mispb-72143050-eaf5-4703-89e0-86624513b4ce-eswincomputing.com
In-Reply-To: <20260703094710.723361F000E9@smtp.kernel.org>
References: <20260703093308.482-1-dongxuyang@eswincomputing.com>
 <20260703093430.699-1-dongxuyang@eswincomputing.com>
 <20260703094710.723361F000E9@smtp.kernel.org>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <476c5c3b.82a5.19f4476dc69.Coremail.dongxuyang@eswincomputing.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:TQJkCgDH3aCE905qb58yAA--.9066W
X-CM-SenderInfo: pgrqw5xx1d0w46hv4xpqfrz1xxwl0woofrz/1tbiAgEDAmpOfBoHp
	wABsh
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWDJw
	CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
	daVFxhVjvjDU=
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[eswincomputing.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9650-lists,linux-pwm=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:sashiko-reviews@lists.linux.dev,m:ukleinek@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:ben-linux@fluff.org,m:ben.dooks@codethink.co.uk,m:p.zabel@pengutronix.de,m:linux-pwm@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:ningyu@eswincomputing.com,m:linmin@eswincomputing.com,m:xuxiang@eswincomputing.com,m:wangguosheng@eswincomputing.com,m:pinkesh.vaghela@einfochips.com,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[dongxuyang@eswincomputing.com,linux-pwm@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORGED_SENDER_FORWARDING(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dongxuyang@eswincomputing.com,linux-pwm@vger.kernel.org];
	HAS_X_PRIO_THREE(0.00)[3];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	R_DKIM_NA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[eswincomputing.com:from_mime,eswincomputing.com:email,eswincomputing.com:mid,vger.kernel.org:from_smtp,sashiko.dev:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D28DC72BA7C

PiAKPiBUaGFuayB5b3UgZm9yIHlvdXIgY29udHJpYnV0aW9uISBTYXNoaWtvIEFJIHJldmlldyBm
b3VuZCAzIHBvdGVudGlhbCBpc3N1ZShzKSB0byBjb25zaWRlcjoKPiAKPiBOZXcgaXNzdWVzOgo+
IC0gW0hpZ2hdIEhhcmR3YXJlIHJlc2V0IGlzIGFzc2VydGVkIGFmdGVyIGdhdGluZyBjbG9ja3Ms
IHdoaWNoIGNhbiBjYXVzZSBidXMgaGFuZ3MuCj4gLSBbSGlnaF0gUmFjZSBjb25kaXRpb24gYmV0
d2VlbiBydW50aW1lIFBNIGNoZWNrIGFuZCBkaXNhYmxlIGNhdXNlcyBhIHBlcm1hbmVudCBjbG9j
ayBsZWFrLgo+IAo+IFByZS1leGlzdGluZyBpc3N1ZXM6Cj4gLSBbSGlnaF0gVW5tYXNraW5nIHRo
ZSB0aW1lciBpbnRlcnJ1cHQgd2l0aG91dCBhbiBJUlEgaGFuZGxlciBjYW4gY2F1c2UgYSBzZXZl
cmUgaW50ZXJydXB0IHN0b3JtLgo+IC0tCj4gCj4gY29tbWl0IGE1MDYwOWJhOTY5MzhjMDJmYmM5
NGY1NDMxOGM5NTU2MWY2NjE3NTgKPiBBdXRob3I6IFh1eWFuZyBEb25nIDxkb25neHV5YW5nQGVz
d2luY29tcHV0aW5nLmNvbT4KPiBTdWJqZWN0OiBwd206IGR3YzogYWRkIG9mL3BsYXRmb3JtIHN1
cHBvcnQKPiAKPiBUaGUgZHdjIHB3bSBjb250cm9sbGVyIGNhbiBiZSB1c2VkIGluIG5vbi1QQ0kg
c3lzdGVtcywgc28gYWxsb3cgZWl0aGVyIAo+IHBsYXRmb3JtIG9yIE9GIGJhc2VkIHByb2Jpbmcu
IEltcGxlbWVudHMgcG9sYXJpdHkgY29udHJvbCBieSBleHBsb2l0aW5nIAo+IHRoZSB0aW1lcidz
IGR1YWwgbG9hZCByZWdpc3RlcnMuCj4gCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9wd20vcHdt
LWR3Yy1jb3JlLmMgYi9kcml2ZXJzL3B3bS9wd20tZHdjLWNvcmUuYwo+ID4gaW5kZXggNmRhYmVj
OTNhM2M2NC4uNDlmMDY1N2Q0YWQ0NCAxMDA2NDQKPiA+IC0tLSBhL2RyaXZlcnMvcHdtL3B3bS1k
d2MtY29yZS5jCj4gPiArKysgYi9kcml2ZXJzL3B3bS9wd20tZHdjLWNvcmUuYwo+IAo+IFsgLi4u
IF0KPiAKPiA+IEBAIC04NSw2ICsxMzgsOSBAQCBzdGF0aWMgaW50IF9fZHdjX3B3bV9jb25maWd1
cmVfdGltZXIoc3RydWN0IGR3Y19wd20gKmR3YywKPiA+ICAJICogcGVyaW9kcyBhcmUgc2V0IGJ5
IExvYWQgQ291bnQgcmVnaXN0ZXJzLgo+ID4gIAkgKi8KPiA+ICAJY3RybCA9IERXQ19USU1fQ1RS
TF9NT0RFX1VTRVIgfCBEV0NfVElNX0NUUkxfUFdNOwo+ID4gKwlpZiAoZHdjLT5mZWF0dXJlcyAm
IERXQ19USU1fQ1RSTF8wTjEwMFBXTV9FTikKPiA+ICsJCWN0cmwgfD0gRFdDX1RJTV9DVFJMXzBO
MTAwUFdNX0VOOwo+ID4gKwo+ID4gIAlkd2NfcHdtX3dyaXRlbChkd2MsIGN0cmwsIERXQ19USU1f
Q1RSTChwd20tPmh3cHdtKSk7Cj4gCj4gW1NldmVyaXR5OiBIaWdoXQo+IFRoaXMgaXNuJ3QgYSBi
dWcgaW50cm9kdWNlZCBieSB0aGlzIHBhdGNoLCBidXQgZG9lcyB3cml0aW5nIHRoaXMgY29udHJv
bAo+IHJlZ2lzdGVyIHVubWFzayB0aGUgdGltZXIgaW50ZXJydXB0Pwo+IAo+IFRoZSBjdHJsIHZh
bHVlIGlzIGNvbnN0cnVjdGVkIHdpdGhvdXQgRFdDX1RJTV9DVFJMX0lOVF9NQVNLIHNldC4gSWYg
dGhpcwo+IGhhcmR3YXJlIGlzIG9uIGFuIE9GIHBsYXRmb3JtIHdoZXJlIGludGVycnVwdHMgYXJl
IGNvbW1vbmx5IHNoYXJlZCwgY291bGQKPiB0aGlzIHVubWFza2VkIHRpbWVyIGZsb29kIHRoZSBz
eXN0ZW0gd2l0aCBpbnRlcnJ1cHRzIHNpbmNlIHRoZXJlIGlzIG5vCj4gSVJRIGhhbmRsZXI/Cj4g
CgpIaSBTYXNoaWtvLAoKV2lsbCBhZGQgRFdDX1RJTV9DVFJMX0lOVF9NQVNLIGluIHRoZSBuZXh0
IHZlcnNpb24uCgo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvcHdtL3B3bS1kd2Mtb2YuYyBiL2Ry
aXZlcnMvcHdtL3B3bS1kd2Mtb2YuYwo+ID4gbmV3IGZpbGUgbW9kZSAxMDA2NDQKPiA+IGluZGV4
IDAwMDAwMDAwMDAwMDAuLjdiYmJmOThkNzY5N2EKPiA+IC0tLSAvZGV2L251bGwKPiA+ICsrKyBi
L2RyaXZlcnMvcHdtL3B3bS1kd2Mtb2YuYwo+IAo+IFsgLi4uIF0KPiAKPiA+ICtzdGF0aWMgdm9p
ZCBkd2NfcHdtX3BsYXRfcmVtb3ZlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpCj4gPiAr
ewo+ID4gKwlzdHJ1Y3QgZHdjX3B3bV9kcnZkYXRhICpkYXRhID0gcGxhdGZvcm1fZ2V0X2RydmRh
dGEocGRldik7Cj4gPiArCXN0cnVjdCBwd21fY2hpcCAqY2hpcCA9IGRhdGEtPmNoaXBzWzBdOwo+
ID4gKwlzdHJ1Y3QgZHdjX3B3bSAqZHdjID0gdG9fZHdjX3B3bShjaGlwKTsKPiA+ICsJdW5zaWdu
ZWQgaW50IGlkeDsKPiA+ICsJaW50IHJldDsKPiA+ICsKPiA+ICsJcHdtY2hpcF9yZW1vdmUoY2hp
cCk7Cj4gPiArCj4gPiArCXJldCA9IHBtX3J1bnRpbWVfcmVzdW1lX2FuZF9nZXQoJnBkZXYtPmRl
dik7Cj4gPiArCWlmIChyZXQgPCAwKSB7Cj4gPiArCQlkZXZfd2FybigmcGRldi0+ZGV2LCAiZmFp
bGVkIHRvIHJlc3VtZSBkZXZpY2U6ICVkXG4iLCByZXQpOwo+ID4gKwl9IGVsc2Ugewo+ID4gKwkJ
Zm9yIChpZHggPSAwOyBpZHggPCBjaGlwLT5ucHdtOyBpZHgrKykgewo+ID4gKwkJCWlmIChkd2Nf
cHdtX3JlYWRsKGR3YywgRFdDX1RJTV9DVFJMKGlkeCkpICYKPiA+ICsJCQkJCSAgRFdDX1RJTV9D
VFJMX0VOKQo+ID4gKwkJCQlwbV9ydW50aW1lX3B1dF9ub2lkbGUoJnBkZXYtPmRldik7Cj4gPiAr
CQl9Cj4gPiArCQlwbV9ydW50aW1lX3B1dF9zeW5jKCZwZGV2LT5kZXYpOwo+ID4gKwl9Cj4gPiAr
Cj4gPiArCWlmICghcG1fcnVudGltZV9zdGF0dXNfc3VzcGVuZGVkKCZwZGV2LT5kZXYpKSB7Cj4g
PiArCQljbGtfZGlzYWJsZV91bnByZXBhcmUoZHdjLT5jbGspOwo+ID4gKwkJY2xrX2Rpc2FibGVf
dW5wcmVwYXJlKGR3Yy0+YnVzX2Nsayk7Cj4gPiArCX0KPiA+ICsJcG1fcnVudGltZV9kaXNhYmxl
KCZwZGV2LT5kZXYpOwo+IAo+IFtTZXZlcml0eTogSGlnaF0KPiBDb3VsZCB0aGlzIG9yZGVyaW5n
IGNhdXNlIGEgcGVybWFuZW50IGNsb2NrIGxlYWsgaWYgYSBjb25jdXJyZW50IHJ1bnRpbWUKPiBQ
TSByZXN1bWUgb2NjdXJzPwo+IAo+IElmIHVzZXJzcGFjZSB0cmlnZ2VycyBhIHJlc3VtZSAoZS5n
LiB2aWEgc3lzZnMpIGJldHdlZW4gdGhlCj4gcG1fcnVudGltZV9zdGF0dXNfc3VzcGVuZGVkKCkg
Y2hlY2sgYW5kIHBtX3J1bnRpbWVfZGlzYWJsZSgpLCB0aGUKPiBkd2NfcHdtX3J1bnRpbWVfcmVz
dW1lKCkgY2FsbGJhY2sgd2lsbCByZS1lbmFibGUgdGhlIGNsb2Nrcy4KPiAKPiBPbmNlIHBtX3J1
bnRpbWVfZGlzYWJsZSgpIHJ1bnMsIHRoZSBQTSBzdGF0ZSBpcyBmcm96ZW4sIGJ1dCB0aGUgZHJp
dmVyIHdpbGwKPiBoYXZlIGxvc3QgdHJhY2sgb2YgdGhlIHJlLWVuYWJsZWQgY2xvY2tzLiBTaG91
bGQgcG1fcnVudGltZV9kaXNhYmxlKCkgYmUKPiBjYWxsZWQgYmVmb3JlIG1hbnVhbGx5IHJvbGxp
bmcgYmFjayB0aGUgY2xvY2sgc3RhdGU/Cj4gCgpDYWxsIHBtX3J1bnRpbWVfZGlzYWJsZSgpIGJl
Zm9yZSBtYW51YWxseSByb2xsaW5nIGJhY2sgdGhlIGNsb2NrIHN0YXRlLgoKPiA+ICsKPiA+ICsJ
aWYgKGR3Yy0+cnN0KSB7Cj4gPiArCQlyZXQgPSByZXNldF9jb250cm9sX2Fzc2VydChkd2MtPnJz
dCk7Cj4gCj4gW1NldmVyaXR5OiBIaWdoXQo+IERvZXMgYXNzZXJ0aW5nIHRoZSByZXNldCB3aGls
ZSB0aGUgSVAgYmxvY2sncyBjbG9ja3MgYXJlIGRpc2FibGVkIGNhdXNlCj4gYSBidXMgbG9ja3Vw
Pwo+IAo+IEluIGR3Y19wd21fcGxhdF9yZW1vdmUoKSwgdGhlIGNsb2NrcyBhcmUgZ3VhcmFudGVl
ZCB0byBiZSBvZmYgaGVyZQo+IChlaXRoZXIgaW1wbGljaXRseSBieSBhbGxvd2luZyB0aGUgZGV2
aWNlIHRvIHN1c3BlbmQsIG9yIGV4cGxpY2l0bHkgdmlhIHRoZQo+IGNsa19kaXNhYmxlX3VucHJl
cGFyZSgpIGNhbGxzIGp1c3QgYWJvdmUpLgo+IAo+IE9uIEFNQkEvQVBCIGJ1c2VzLCBhc3NlcnRp
bmcgYSByZXNldCBvbiBhbiB1bmNsb2NrZWQgSVAgYmxvY2sgb2Z0ZW4gcHJldmVudHMKPiB0aGUg
cmVzZXQgc2lnbmFsIGZyb20gcHJvcGFnYXRpbmcsIGxlYWRpbmcgdG8gYSBzeXN0ZW0gaGFuZyB3
aGVuIHRoZSByZXNldAo+IGNvbnRyb2xsZXIgYXR0ZW1wdHMgdG8gY29tcGxldGUgdGhlIHRyYW5z
YWN0aW9uLgo+IAoKUmVtb3ZlIHJlc2V0IGFzc2VydCBpbiByZW1vdmUgZnVuY3Rpb24sIGFzIGRp
c2FibGluZyBQTSBhbmQgY2xvY2tzCnByZXZlbnRzIGZ1cnRoZXIgb3BlcmF0aW9uCgpCZXN0IHJl
Z2FyZHMsClh1eWFuZyBEb25nCgo+ID4gKwkJaWYgKHJldCkKPiA+ICsJCQlkZXZfd2FybigmcGRl
di0+ZGV2LCAiZmFpbGVkIHRvIGFzc2VydCByZXNldDogJWRcbiIsCj4gPiArCQkJCSByZXQpOwo+
ID4gKwl9Cj4gPiArfQo+IAo+IC0tIAo+IFNhc2hpa28gQUkgcmV2aWV3IMK3IGh0dHBzOi8vc2Fz
aGlrby5kZXYvIy9wYXRjaHNldC8yMDI2MDcwMzA5MzMwOC40ODItMS1kb25neHV5YW5nQGVzd2lu
Y29tcHV0aW5nLmNvbT9wYXJ0PTMK

