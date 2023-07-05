Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84493747F19
	for <lists+linux-pwm@lfdr.de>; Wed,  5 Jul 2023 10:10:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231842AbjGEIK6 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 5 Jul 2023 04:10:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231140AbjGEIK5 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 5 Jul 2023 04:10:57 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF55E123;
        Wed,  5 Jul 2023 01:10:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1688544647;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Com+PgV88N4KHKqJcbrIdqtg5KLP8VcfZH7DJNRs7vY=;
        b=XB3SqodHLoS6Ad9dI9O06eXJDGR9lP8BcW7gGzss3zvcQrwIyWPHp1pbN//iTq9BsNNzM5
        Z2pIetVgGMOQH/w5trlSp+va/d9KOyXAseHwWS1S5hVKj0hl85sVXjJSCKs2mZL+mJp12b
        1JdPTRTfEnotPrDbM0yviKfT/0ylAR8=
Message-ID: <eb033a2a8acf7b9d98596ead947bd3bec990f887.camel@crapouillou.net>
Subject: Re: [PATCH v2 3/8] pwm: jz4740: Put per-channel clk into driver data
From:   Paul Cercueil <paul@crapouillou.net>
To:     Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
        linux-mips@vger.kernel.org, linux-pwm@vger.kernel.org,
        kernel@pengutronix.de
Date:   Wed, 05 Jul 2023 10:10:45 +0200
In-Reply-To: <20230705080650.2353391-4-u.kleine-koenig@pengutronix.de>
References: <20230705080650.2353391-1-u.kleine-koenig@pengutronix.de>
         <20230705080650.2353391-4-u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

TGUgbWVyY3JlZGkgMDUganVpbGxldCAyMDIzIMOgIDEwOjA2ICswMjAwLCBVd2UgS2xlaW5lLUvD
tm5pZyBhIMOpY3JpdMKgOgo+IFN0b3AgdXNpbmcgY2hpcF9kYXRhIHdoaWNoIGlzIGFib3V0IHRv
IGdvIGF3YXkuIEluc3RlYWQgdHJhY2sgdGhlCj4gcGVyLWNoYW5uZWwgY2xrIGluIHN0cnVjdCBq
ejQ3NDBfcHdtX2NoaXAuCj4gCj4gUmV2aWV3ZWQtYnk6IFBoaWxpcHBlIE1hdGhpZXUtRGF1ZMOp
IDxwaGlsbWRAbGluYXJvLm9yZz4KPiBTaWduZWQtb2ZmLWJ5OiBVd2UgS2xlaW5lLUvDtm5pZyA8
dS5rbGVpbmUta29lbmlnQHBlbmd1dHJvbml4LmRlPgoKUmV2aWV3ZWQtYnk6IFBhdWwgQ2VyY3Vl
aWwgPHBhdWxAY3JhcG91aWxsb3UubmV0PgoKQ2hlZXJzLAotUGF1bAoKPiAtLS0KPiDCoGRyaXZl
cnMvcHdtL3B3bS1qejQ3NDAuYyB8IDExICsrKysrKystLS0tCj4gwqAxIGZpbGUgY2hhbmdlZCwg
NyBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQo+IAo+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L3B3bS9wd20tano0NzQwLmMgYi9kcml2ZXJzL3B3bS9wd20tano0NzQwLmMKPiBpbmRleCAzYjcw
NjdmNmNkMGQuLjhiMDE4MTlkZjY3ZCAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL3B3bS9wd20tano0
NzQwLmMKPiArKysgYi9kcml2ZXJzL3B3bS9wd20tano0NzQwLmMKPiBAQCAtMjcsNiArMjcsNyBA
QCBzdHJ1Y3Qgc29jX2luZm8gewo+IMKgc3RydWN0IGp6NDc0MF9wd21fY2hpcCB7Cj4gwqDCoMKg
wqDCoMKgwqDCoHN0cnVjdCBwd21fY2hpcCBjaGlwOwo+IMKgwqDCoMKgwqDCoMKgwqBzdHJ1Y3Qg
cmVnbWFwICptYXA7Cj4gK8KgwqDCoMKgwqDCoMKgc3RydWN0IGNsayAqY2xrW107Cj4gwqB9Owo+
IMKgCj4gwqBzdGF0aWMgaW5saW5lIHN0cnVjdCBqejQ3NDBfcHdtX2NoaXAgKnRvX2p6NDc0MChz
dHJ1Y3QgcHdtX2NoaXAKPiAqY2hpcCkKPiBAQCAtNzAsMTQgKzcxLDE1IEBAIHN0YXRpYyBpbnQg
ano0NzQwX3B3bV9yZXF1ZXN0KHN0cnVjdCBwd21fY2hpcAo+ICpjaGlwLCBzdHJ1Y3QgcHdtX2Rl
dmljZSAqcHdtKQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcmV0dXJuIGVycjsK
PiDCoMKgwqDCoMKgwqDCoMKgfQo+IMKgCj4gLcKgwqDCoMKgwqDCoMKgcHdtX3NldF9jaGlwX2Rh
dGEocHdtLCBjbGspOwo+ICvCoMKgwqDCoMKgwqDCoGp6LT5jbGtbcHdtLT5od3B3bV0gPSBjbGs7
Cj4gwqAKPiDCoMKgwqDCoMKgwqDCoMKgcmV0dXJuIDA7Cj4gwqB9Cj4gwqAKPiDCoHN0YXRpYyB2
b2lkIGp6NDc0MF9wd21fZnJlZShzdHJ1Y3QgcHdtX2NoaXAgKmNoaXAsIHN0cnVjdCBwd21fZGV2
aWNlCj4gKnB3bSkKPiDCoHsKPiAtwqDCoMKgwqDCoMKgwqBzdHJ1Y3QgY2xrICpjbGsgPSBwd21f
Z2V0X2NoaXBfZGF0YShwd20pOwo+ICvCoMKgwqDCoMKgwqDCoHN0cnVjdCBqejQ3NDBfcHdtX2No
aXAgKmp6ID0gdG9fano0NzQwKGNoaXApOwo+ICvCoMKgwqDCoMKgwqDCoHN0cnVjdCBjbGsgKmNs
ayA9IGp6LT5jbGtbcHdtLT5od3B3bV07Cj4gwqAKPiDCoMKgwqDCoMKgwqDCoMKgY2xrX2Rpc2Fi
bGVfdW5wcmVwYXJlKGNsayk7Cj4gwqDCoMKgwqDCoMKgwqDCoGNsa19wdXQoY2xrKTsKPiBAQCAt
MTIzLDcgKzEyNSw3IEBAIHN0YXRpYyBpbnQgano0NzQwX3B3bV9hcHBseShzdHJ1Y3QgcHdtX2No
aXAKPiAqY2hpcCwgc3RydWN0IHB3bV9kZXZpY2UgKnB3bSwKPiDCoHsKPiDCoMKgwqDCoMKgwqDC
oMKgc3RydWN0IGp6NDc0MF9wd21fY2hpcCAqano0NzQwID0gdG9fano0NzQwKHB3bS0+Y2hpcCk7
Cj4gwqDCoMKgwqDCoMKgwqDCoHVuc2lnbmVkIGxvbmcgbG9uZyB0bXAgPSAweGZmZmZ1bGwgKiBO
U0VDX1BFUl9TRUM7Cj4gLcKgwqDCoMKgwqDCoMKgc3RydWN0IGNsayAqY2xrID0gcHdtX2dldF9j
aGlwX2RhdGEocHdtKTsKPiArwqDCoMKgwqDCoMKgwqBzdHJ1Y3QgY2xrICpjbGsgPSBqejQ3NDAt
PmNsa1twd20tPmh3cHdtXTsKPiDCoMKgwqDCoMKgwqDCoMKgdW5zaWduZWQgbG9uZyBwZXJpb2Qs
IGR1dHk7Cj4gwqDCoMKgwqDCoMKgwqDCoGxvbmcgcmF0ZTsKPiDCoMKgwqDCoMKgwqDCoMKgaW50
IGVycjsKPiBAQCAtMjI5LDcgKzIzMSw4IEBAIHN0YXRpYyBpbnQgano0NzQwX3B3bV9wcm9iZShz
dHJ1Y3QKPiBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpCj4gwqDCoMKgwqDCoMKgwqDCoGlmICghaW5m
bykKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJldHVybiAtRUlOVkFMOwo+IMKg
Cj4gLcKgwqDCoMKgwqDCoMKgano0NzQwID0gZGV2bV9remFsbG9jKGRldiwgc2l6ZW9mKCpqejQ3
NDApLCBHRlBfS0VSTkVMKTsKPiArwqDCoMKgwqDCoMKgwqBqejQ3NDAgPSBkZXZtX2t6YWxsb2Mo
ZGV2LCBzdHJ1Y3Rfc2l6ZShqejQ3NDAsIGNsaywgaW5mby0KPiA+bnVtX3B3bXMpLAo+ICvCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBHRlBf
S0VSTkVMKTsKPiDCoMKgwqDCoMKgwqDCoMKgaWYgKCFqejQ3NDApCj4gwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqByZXR1cm4gLUVOT01FTTsKPiDCoAoK

