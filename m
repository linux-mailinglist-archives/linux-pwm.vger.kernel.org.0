Return-Path: <linux-pwm+bounces-2478-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CA5C909A54
	for <lists+linux-pwm@lfdr.de>; Sun, 16 Jun 2024 01:10:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3715283119
	for <lists+linux-pwm@lfdr.de>; Sat, 15 Jun 2024 23:10:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3060749647;
	Sat, 15 Jun 2024 23:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="aAMpz1ZU"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F4D5171B0;
	Sat, 15 Jun 2024 23:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718493046; cv=none; b=U9JAAXeaRINtrDU2q/f6Mm+/68bYArO58p4x+9C6JvRSAYMvVfKMG4ZVLs0VnDkrsb5ApV0o3F2Gj3CK5agQ4JzjHxfyRYEZs78mKLOdEXMnVBgDJ64/+nIHEccT6f4iyXbRN8JaHq0JgIwDirEOsFi6mxpvdiz2SHEGK2UJOV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718493046; c=relaxed/simple;
	bh=9UCyQZoOJ9zDQjCc2wL1CUbLLfqA0rfziWeE2+5Ta4M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ASXWkYTx9gyDZBlcEA8fsAFOf9SQrWlns8X69Y2DNyxVzySPkCorg3QAfMcH7WiQhC5POmuYkasLSu4u4uB9UK/6qLMcdKSZ74NwghvrMl5q6lKpDuWEUcIqWzofaEPzlLi3mS42+IlMgNCL+JvyQlcetX2pIL2tnRTnXwc6jOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=aAMpz1ZU; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1f6da06ba24so29074725ad.2;
        Sat, 15 Jun 2024 16:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1718493044; x=1719097844; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7R40NGjhA4iIhadDR9M6U6xqU98YvFHgUqsKkQpjspQ=;
        b=aAMpz1ZUdtmvpXlxAwMyEnylrbCARJtuSeVGvXL73z/FPiGrQFeaSxj1WGnQqWv1RT
         LItWnYtdQp3siPAR1UGcIyBArrjVZZTh+n1l3KZS1QPHTJfr0IDirb4uj38i2kc++I2I
         kZBGwFbci9YxS9bmOE3YYo+ob0utvcK4Y1S8Dt7pyAljTIr3BzITPVVO4Tg5jL6Ier4/
         noIH1W1ncV+P9Uvi1c/SCaCuChwT6jbzxB1lOX+kZn1cIVIVwI9mWtXtQLag9zfkyPxo
         IjJ2893e7kVPl8AZWS99o18TczfKNLHNT3ojetcQZLlNc5l2WbuJ7PX1XCNXUuGaGfEG
         rnwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718493044; x=1719097844;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7R40NGjhA4iIhadDR9M6U6xqU98YvFHgUqsKkQpjspQ=;
        b=QiSVUOuha/b8lFyECywnokDuRU0N1BQcHwwkga9CoFSW3PLDoLHI087yslJ0H4qynl
         JZUJ+Cy8zqAgAfqlkariU5ZjTjaKFu1CSK3C/BfOIk1DHpNkI0Do7RJ2wgSslzmbgsgt
         f6nnwQeivXwMZrF+xoGYREpjt1ckXRpfdo3wBxgqFgVbLMp1BHr4myu70w9xAhadK0Gw
         SeqyE5lITiHycg6L2qfQ27cLkzzjwKXJXc/CH6RLkYxYvxPm+Ik77/lhfqo3uatSLn/T
         pvA81evgITyFC+iBn70gJm3s8nKIkGayNSacTzry4QSCnBYucP7Cn0zi8FLbrXXK7BP9
         NX0g==
X-Forwarded-Encrypted: i=1; AJvYcCX7oLZz3TX1R3VSFP8Gt+LLB4x90BIMu3LP1bp5/wRHMxxjSQp6h3bM+bX5+4pPAtHxlzCLDGEjkTUI5/72lzsejnFkA31XmUvs6+GFXrc6nCQnx28QvNXIRWfNkSYPCEjtODJpS4Fz
X-Gm-Message-State: AOJu0YyWrBOfXe86Z/5NKOVcfApfFJVbZdTFUAwTlz+p8Sc9CK5/6xKr
	lB9SaZG2bMDeIno6Vrp1GZDaUx/wmaxPy7+/f5iARKds5moX7LNxr1Oq+4rIh95IcYP5CcQd6N0
	6/jbo9A0VT3aSxkNcMg8UjBmeXpZKx9r+
X-Google-Smtp-Source: AGHT+IG1XQ7zZ3Xnf+DRLcpyZe0j5jFWGskVgTwVRTUDGmlqtnAaQXDSXLo86TUOs1tgU4FSwL6RQXkgb8/CB8widKI=
X-Received: by 2002:a17:903:1c7:b0:1f7:364f:1162 with SMTP id
 d9443c01a7336-1f8627cb650mr69288645ad.31.1718493043566; Sat, 15 Jun 2024
 16:10:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240610104600.458308-2-u.kleine-koenig@baylibre.com>
In-Reply-To: <20240610104600.458308-2-u.kleine-koenig@baylibre.com>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Sun, 16 Jun 2024 01:10:32 +0200
Message-ID: <CAFBinCB+S1wOpD-fCbcTORqXSV00Sd7-1GHUKY+rO859_dkhOA@mail.gmail.com>
Subject: Re: [RFC PATCH] regulator: pwm-regulator: Make assumptions about
 disabled PWM consistent
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000694344061af5d7be"

--000000000000694344061af5d7be
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Uwe,

On Mon, Jun 10, 2024 at 12:46=E2=80=AFPM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@baylibre.com> wrote:
[...]
> this is my suggestion to fix the concerns I expressed in
> https://lore.kernel.org/all/hf24mrplr76xtziztkqiscowkh2f3vmceuarecqcwnr6u=
dggs6@uiof2rvvqq5v/
> .
>
> It's only compile tested as I don't have a machine with a pwm-regulator.
> So getting test feedback before applying it would be great.
Unfortunately this approach breaks my Odroid-C1 board again with the
same symptoms as before the mentioned commits: random memory
corruption, preventing the board from booting to userspace.

The cause also seems to be the same as before my commits:
- period (3666ns) and duty cycle (3333ns) in the hardware registers
the PWM controller when Linux boots, but the PWM output is disabled
- with a duty cycle of 0 or PWM output being disabled the output of
the voltage regulator is 1140mV, which is the only allowed voltage for
that rail (even though the regulator can achieve other voltages)
- pwm_regulator_enable() calls pwm_enable() which simply takes the
period and and duty cycle that was read back from the hardware and
enables the output, resulting in undervolting of a main voltage rail
of the SoC

I hope that this (especially the last item) also clarifies the
question you had in the linked mail on whether updating
pwm_regulator_init_state() would help/work.

Regarding your alternative and preferred approach from the other mail:
> Alternatively (and IMHO nicer) just keep the pwm_state around and don't
> use the (mis) feature of the PWM core that pwm_get_state only returns
> the last set state.
I tried this to see if it would work also for my Odroid-C1 board and
I'm happy to report it does - see the attached diff.
In case you are happy with this approach I can submit it as a proper patch.


Best regards,
Martin

--000000000000694344061af5d7be
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="pwm-regulator-keep-pwm-state-around.diff"
Content-Disposition: attachment; 
	filename="pwm-regulator-keep-pwm-state-around.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_lxgqakbn0>
X-Attachment-Id: f_lxgqakbn0

ZGlmZiAtLWdpdCBhL2RyaXZlcnMvcmVndWxhdG9yL3B3bS1yZWd1bGF0b3IuYyBiL2RyaXZlcnMv
cmVndWxhdG9yL3B3bS1yZWd1bGF0b3IuYwppbmRleCA3NDM0YjZiMjJkMzIuLmFiNmZjOTkwNWJi
MiAxMDA2NDQKLS0tIGEvZHJpdmVycy9yZWd1bGF0b3IvcHdtLXJlZ3VsYXRvci5jCisrKyBiL2Ry
aXZlcnMvcmVndWxhdG9yL3B3bS1yZWd1bGF0b3IuYwpAQCAtNDEsNiArNDEsOCBAQCBzdHJ1Y3Qg
cHdtX3JlZ3VsYXRvcl9kYXRhIHsKIAogCS8qIEVuYWJsZSBHUElPICovCiAJc3RydWN0IGdwaW9f
ZGVzYyAqZW5iX2dwaW87CisKKwlzdHJ1Y3QgcHdtX3N0YXRlIHB3bV9zdGF0ZTsKIH07CiAKIHN0
cnVjdCBwd21fdm9sdGFnZXMgewpAQCAtNDgsMTggKzUwLDMzIEBAIHN0cnVjdCBwd21fdm9sdGFn
ZXMgewogCXVuc2lnbmVkIGludCBkdXR5Y3ljbGU7CiB9OwogCitzdGF0aWMgaW50IHB3bV9yZWd1
bGF0b3JfYXBwbHlfc3RhdGUoc3RydWN0IHJlZ3VsYXRvcl9kZXYgKnJkZXYsCisJCQkJICAgICBz
dHJ1Y3QgcHdtX3N0YXRlICpuZXdfc3RhdGUpCit7CisJc3RydWN0IHB3bV9yZWd1bGF0b3JfZGF0
YSAqZHJ2ZGF0YSA9IHJkZXZfZ2V0X2RydmRhdGEocmRldik7CisJaW50IHJldDsKKworCXJldCA9
IHB3bV9hcHBseV9taWdodF9zbGVlcChkcnZkYXRhLT5wd20sIG5ld19zdGF0ZSk7CisJaWYgKHJl
dCkgeworCQlkZXZfZXJyKCZyZGV2LT5kZXYsICJGYWlsZWQgdG8gY29uZmlndXJlIFBXTTogJWRc
biIsIHJldCk7CisJCXJldHVybiByZXQ7CisJfQorCisJZHJ2ZGF0YS0+cHdtX3N0YXRlID0gKm5l
d19zdGF0ZTsKKworCXJldHVybiAwOworfQorCiAvKgogICogVm9sdGFnZSB0YWJsZSBjYWxsLWJh
Y2tzCiAgKi8KIHN0YXRpYyB2b2lkIHB3bV9yZWd1bGF0b3JfaW5pdF9zdGF0ZShzdHJ1Y3QgcmVn
dWxhdG9yX2RldiAqcmRldikKIHsKIAlzdHJ1Y3QgcHdtX3JlZ3VsYXRvcl9kYXRhICpkcnZkYXRh
ID0gcmRldl9nZXRfZHJ2ZGF0YShyZGV2KTsKLQlzdHJ1Y3QgcHdtX3N0YXRlIHB3bV9zdGF0ZTsK
IAl1bnNpZ25lZCBpbnQgZHV0eWN5Y2xlOwogCWludCBpOwogCi0JcHdtX2dldF9zdGF0ZShkcnZk
YXRhLT5wd20sICZwd21fc3RhdGUpOwotCWR1dHljeWNsZSA9IHB3bV9nZXRfcmVsYXRpdmVfZHV0
eV9jeWNsZSgmcHdtX3N0YXRlLCAxMDApOworCWR1dHljeWNsZSA9IHB3bV9nZXRfcmVsYXRpdmVf
ZHV0eV9jeWNsZSgmZHJ2ZGF0YS0+cHdtX3N0YXRlLCAxMDApOwogCiAJZm9yIChpID0gMDsgaSA8
IHJkZXYtPmRlc2MtPm5fdm9sdGFnZXM7IGkrKykgewogCQlpZiAoZHV0eWN5Y2xlID09IGRydmRh
dGEtPmR1dHlfY3ljbGVfdGFibGVbaV0uZHV0eWN5Y2xlKSB7CkBAIC04MywxOCArMTAwLDE1IEBA
IHN0YXRpYyBpbnQgcHdtX3JlZ3VsYXRvcl9zZXRfdm9sdGFnZV9zZWwoc3RydWN0IHJlZ3VsYXRv
cl9kZXYgKnJkZXYsCiAJCQkJCSB1bnNpZ25lZCBzZWxlY3RvcikKIHsKIAlzdHJ1Y3QgcHdtX3Jl
Z3VsYXRvcl9kYXRhICpkcnZkYXRhID0gcmRldl9nZXRfZHJ2ZGF0YShyZGV2KTsKLQlzdHJ1Y3Qg
cHdtX3N0YXRlIHBzdGF0ZTsKKwlzdHJ1Y3QgcHdtX3N0YXRlIHBzdGF0ZSA9IGRydmRhdGEtPnB3
bV9zdGF0ZTsKIAlpbnQgcmV0OwogCi0JcHdtX2luaXRfc3RhdGUoZHJ2ZGF0YS0+cHdtLCAmcHN0
YXRlKTsKIAlwd21fc2V0X3JlbGF0aXZlX2R1dHlfY3ljbGUoJnBzdGF0ZSwKIAkJCWRydmRhdGEt
PmR1dHlfY3ljbGVfdGFibGVbc2VsZWN0b3JdLmR1dHljeWNsZSwgMTAwKTsKIAotCXJldCA9IHB3
bV9hcHBseV9taWdodF9zbGVlcChkcnZkYXRhLT5wd20sICZwc3RhdGUpOwotCWlmIChyZXQpIHsK
LQkJZGV2X2VycigmcmRldi0+ZGV2LCAiRmFpbGVkIHRvIGNvbmZpZ3VyZSBQV006ICVkXG4iLCBy
ZXQpOworCXJldCA9IHB3bV9yZWd1bGF0b3JfYXBwbHlfc3RhdGUocmRldiwgJnBzdGF0ZSk7CisJ
aWYgKHJldCkKIAkJcmV0dXJuIHJldDsKLQl9CiAKIAlkcnZkYXRhLT5zdGF0ZSA9IHNlbGVjdG9y
OwogCkBAIC0xMTUsMTcgKzEyOSwyNiBAQCBzdGF0aWMgaW50IHB3bV9yZWd1bGF0b3JfbGlzdF92
b2x0YWdlKHN0cnVjdCByZWd1bGF0b3JfZGV2ICpyZGV2LAogc3RhdGljIGludCBwd21fcmVndWxh
dG9yX2VuYWJsZShzdHJ1Y3QgcmVndWxhdG9yX2RldiAqZGV2KQogewogCXN0cnVjdCBwd21fcmVn
dWxhdG9yX2RhdGEgKmRydmRhdGEgPSByZGV2X2dldF9kcnZkYXRhKGRldik7CisJc3RydWN0IHB3
bV9zdGF0ZSBwc3RhdGUgPSBkcnZkYXRhLT5wd21fc3RhdGU7CiAKIAlncGlvZF9zZXRfdmFsdWVf
Y2Fuc2xlZXAoZHJ2ZGF0YS0+ZW5iX2dwaW8sIDEpOwogCi0JcmV0dXJuIHB3bV9lbmFibGUoZHJ2
ZGF0YS0+cHdtKTsKKwlwc3RhdGUuZW5hYmxlZCA9IHRydWU7CisKKwlyZXR1cm4gcHdtX3JlZ3Vs
YXRvcl9hcHBseV9zdGF0ZShkZXYsICZwc3RhdGUpOwogfQogCiBzdGF0aWMgaW50IHB3bV9yZWd1
bGF0b3JfZGlzYWJsZShzdHJ1Y3QgcmVndWxhdG9yX2RldiAqZGV2KQogewogCXN0cnVjdCBwd21f
cmVndWxhdG9yX2RhdGEgKmRydmRhdGEgPSByZGV2X2dldF9kcnZkYXRhKGRldik7CisJc3RydWN0
IHB3bV9zdGF0ZSBwc3RhdGUgPSBkcnZkYXRhLT5wd21fc3RhdGU7CisJaW50IHJldDsKKworCXBz
dGF0ZS5lbmFibGVkID0gZmFsc2U7CiAKLQlwd21fZGlzYWJsZShkcnZkYXRhLT5wd20pOworCXJl
dCA9IHB3bV9yZWd1bGF0b3JfYXBwbHlfc3RhdGUoZGV2LCAmcHN0YXRlKTsKKwlpZiAocmV0KQor
CQlyZXR1cm4gcmV0OwogCiAJZ3Bpb2Rfc2V0X3ZhbHVlX2NhbnNsZWVwKGRydmRhdGEtPmVuYl9n
cGlvLCAwKTsKIApAQCAtMTUxLDIwICsxNzQsMTAgQEAgc3RhdGljIGludCBwd21fcmVndWxhdG9y
X2dldF92b2x0YWdlKHN0cnVjdCByZWd1bGF0b3JfZGV2ICpyZGV2KQogCWludCBtaW5fdVYgPSBy
ZGV2LT5jb25zdHJhaW50cy0+bWluX3VWOwogCWludCBtYXhfdVYgPSByZGV2LT5jb25zdHJhaW50
cy0+bWF4X3VWOwogCWludCBkaWZmX3VWID0gbWF4X3VWIC0gbWluX3VWOwotCXN0cnVjdCBwd21f
c3RhdGUgcHN0YXRlOwogCXVuc2lnbmVkIGludCBkaWZmX2R1dHk7CiAJdW5zaWduZWQgaW50IHZv
bHRhZ2U7CiAKLQlwd21fZ2V0X3N0YXRlKGRydmRhdGEtPnB3bSwgJnBzdGF0ZSk7Ci0KLQlpZiAo
IXBzdGF0ZS5lbmFibGVkKSB7Ci0JCWlmIChwc3RhdGUucG9sYXJpdHkgPT0gUFdNX1BPTEFSSVRZ
X0lOVkVSU0VEKQotCQkJcHN0YXRlLmR1dHlfY3ljbGUgPSBwc3RhdGUucGVyaW9kOwotCQllbHNl
Ci0JCQlwc3RhdGUuZHV0eV9jeWNsZSA9IDA7Ci0JfQotCi0Jdm9sdGFnZSA9IHB3bV9nZXRfcmVs
YXRpdmVfZHV0eV9jeWNsZSgmcHN0YXRlLCBkdXR5X3VuaXQpOworCXZvbHRhZ2UgPSBwd21fZ2V0
X3JlbGF0aXZlX2R1dHlfY3ljbGUoJmRydmRhdGEtPnB3bV9zdGF0ZSwgZHV0eV91bml0KTsKIAlp
ZiAodm9sdGFnZSA8IG1pbihtYXhfdVZfZHV0eSwgbWluX3VWX2R1dHkpIHx8CiAJICAgIHZvbHRh
Z2UgPiBtYXgobWF4X3VWX2R1dHksIG1pbl91Vl9kdXR5KSkKIAkJcmV0dXJuIC1FTk9UUkVDT1ZF
UkFCTEU7CkBAIC0xOTUsMTUgKzIwOCwxMiBAQCBzdGF0aWMgaW50IHB3bV9yZWd1bGF0b3Jfc2V0
X3ZvbHRhZ2Uoc3RydWN0IHJlZ3VsYXRvcl9kZXYgKnJkZXYsCiAJdW5zaWduZWQgaW50IG1pbl91
Vl9kdXR5ID0gZHJ2ZGF0YS0+Y29udGludW91cy5taW5fdVZfZHV0eWN5Y2xlOwogCXVuc2lnbmVk
IGludCBtYXhfdVZfZHV0eSA9IGRydmRhdGEtPmNvbnRpbnVvdXMubWF4X3VWX2R1dHljeWNsZTsK
IAl1bnNpZ25lZCBpbnQgZHV0eV91bml0ID0gZHJ2ZGF0YS0+Y29udGludW91cy5kdXR5Y3ljbGVf
dW5pdDsKKwlzdHJ1Y3QgcHdtX3N0YXRlIHBzdGF0ZSA9IGRydmRhdGEtPnB3bV9zdGF0ZTsKIAlp
bnQgbWluX3VWID0gcmRldi0+Y29uc3RyYWludHMtPm1pbl91VjsKIAlpbnQgbWF4X3VWID0gcmRl
di0+Y29uc3RyYWludHMtPm1heF91VjsKIAlpbnQgZGlmZl91ViA9IG1heF91ViAtIG1pbl91VjsK
LQlzdHJ1Y3QgcHdtX3N0YXRlIHBzdGF0ZTsKIAl1bnNpZ25lZCBpbnQgZGlmZl9kdXR5OwogCXVu
c2lnbmVkIGludCBkdXR5Y3ljbGU7Ci0JaW50IHJldDsKLQotCXB3bV9pbml0X3N0YXRlKGRydmRh
dGEtPnB3bSwgJnBzdGF0ZSk7CiAKIAkvKgogCSAqIFRoZSBkdXR5Y3ljbGUgZm9yIG1pbl91ViBt
aWdodCBiZSBncmVhdGVyIHRoYW4gdGhlIG9uZSBmb3IgbWF4X3VWLgpAQCAtMjI2LDEzICsyMzYs
NyBAQCBzdGF0aWMgaW50IHB3bV9yZWd1bGF0b3Jfc2V0X3ZvbHRhZ2Uoc3RydWN0IHJlZ3VsYXRv
cl9kZXYgKnJkZXYsCiAKIAlwd21fc2V0X3JlbGF0aXZlX2R1dHlfY3ljbGUoJnBzdGF0ZSwgZHV0
eWN5Y2xlLCBkdXR5X3VuaXQpOwogCi0JcmV0ID0gcHdtX2FwcGx5X21pZ2h0X3NsZWVwKGRydmRh
dGEtPnB3bSwgJnBzdGF0ZSk7Ci0JaWYgKHJldCkgewotCQlkZXZfZXJyKCZyZGV2LT5kZXYsICJG
YWlsZWQgdG8gY29uZmlndXJlIFBXTTogJWRcbiIsIHJldCk7Ci0JCXJldHVybiByZXQ7Ci0JfQot
Ci0JcmV0dXJuIDA7CisJcmV0dXJuIHB3bV9yZWd1bGF0b3JfYXBwbHlfc3RhdGUocmRldiwgJnBz
dGF0ZSk7CiB9CiAKIHN0YXRpYyBjb25zdCBzdHJ1Y3QgcmVndWxhdG9yX29wcyBwd21fcmVndWxh
dG9yX3ZvbHRhZ2VfdGFibGVfb3BzID0gewpAQCAtMzIxLDMyICszMjUsNiBAQCBzdGF0aWMgaW50
IHB3bV9yZWd1bGF0b3JfaW5pdF9jb250aW51b3VzKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBk
ZXYsCiAJcmV0dXJuIDA7CiB9CiAKLXN0YXRpYyBpbnQgcHdtX3JlZ3VsYXRvcl9pbml0X2Jvb3Rf
b24oc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldiwKLQkJCQkgICAgICBzdHJ1Y3QgcHdtX3Jl
Z3VsYXRvcl9kYXRhICpkcnZkYXRhLAotCQkJCSAgICAgIGNvbnN0IHN0cnVjdCByZWd1bGF0b3Jf
aW5pdF9kYXRhICppbml0X2RhdGEpCi17Ci0Jc3RydWN0IHB3bV9zdGF0ZSBwc3RhdGU7Ci0KLQlp
ZiAoIWluaXRfZGF0YS0+Y29uc3RyYWludHMuYm9vdF9vbiB8fCBkcnZkYXRhLT5lbmJfZ3BpbykK
LQkJcmV0dXJuIDA7Ci0KLQlwd21fZ2V0X3N0YXRlKGRydmRhdGEtPnB3bSwgJnBzdGF0ZSk7Ci0J
aWYgKHBzdGF0ZS5lbmFibGVkKQotCQlyZXR1cm4gMDsKLQotCS8qCi0JICogVXBkYXRlIHRoZSBk
dXR5IGN5Y2xlIHNvIHRoZSBvdXRwdXQgZG9lcyBub3QgY2hhbmdlCi0JICogd2hlbiB0aGUgcmVn
dWxhdG9yIGNvcmUgZW5hYmxlcyB0aGUgcmVndWxhdG9yIChhbmQKLQkgKiB0aHVzIHRoZSBQV00g
Y2hhbm5lbCkuCi0JICovCi0JaWYgKHBzdGF0ZS5wb2xhcml0eSA9PSBQV01fUE9MQVJJVFlfSU5W
RVJTRUQpCi0JCXBzdGF0ZS5kdXR5X2N5Y2xlID0gcHN0YXRlLnBlcmlvZDsKLQllbHNlCi0JCXBz
dGF0ZS5kdXR5X2N5Y2xlID0gMDsKLQotCXJldHVybiBwd21fYXBwbHlfbWlnaHRfc2xlZXAoZHJ2
ZGF0YS0+cHdtLCAmcHN0YXRlKTsKLX0KLQogc3RhdGljIGludCBwd21fcmVndWxhdG9yX3Byb2Jl
KHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpCiB7CiAJY29uc3Qgc3RydWN0IHJlZ3VsYXRv
cl9pbml0X2RhdGEgKmluaXRfZGF0YTsKQEAgLTQwNCwxMCArMzgyLDIzIEBAIHN0YXRpYyBpbnQg
cHdtX3JlZ3VsYXRvcl9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQogCWlmIChy
ZXQpCiAJCXJldHVybiByZXQ7CiAKLQlyZXQgPSBwd21fcmVndWxhdG9yX2luaXRfYm9vdF9vbihw
ZGV2LCBkcnZkYXRhLCBpbml0X2RhdGEpOwotCWlmIChyZXQpCi0JCXJldHVybiBkZXZfZXJyX3By
b2JlKCZwZGV2LT5kZXYsIHJldCwKLQkJCQkgICAgICJGYWlsZWQgdG8gYXBwbHkgYm9vdF9vbiBz
ZXR0aW5nc1xuIik7CisJcHdtX2luaXRfc3RhdGUoZHJ2ZGF0YS0+cHdtLCAmZHJ2ZGF0YS0+cHdt
X3N0YXRlKTsKKworCWlmIChpbml0X2RhdGEtPmNvbnN0cmFpbnRzLmJvb3Rfb24gJiYgIWRydmRh
dGEtPmVuYl9ncGlvICYmCisJICAgICFkcnZkYXRhLT5wd21fc3RhdGUuZW5hYmxlZCkKKwkJLyoK
KwkJKiBJbiBnZW5lcmFsIGl0J3MgdW5rbm93biB3aGF0IHRoZSBvdXRwdXQgb2YgYSBkaXNhYmxl
ZCBQV00gaXMuCisJCSogVGhlIG9ubHkgc2FuZSBhc3N1bXB0aW9uIGhlcmUgaXMgaXQgZW1pdHMg
dGhlIGluYWN0aXZlIGxldmVsCisJCSogd2hpY2ggY29ycmVzcG9uZHMgdG8gZHV0eV9jeWNsZSA9
IDAgKGluZGVwZW5kZW50IG9mIHRoZQorCQkqIHBvbGFyaXR5KS4KKwkJKgorCQkqIFVwZGF0ZSB0
aGUgZHV0eSBjeWNsZSBzbyB0aGUgb3V0cHV0IGRvZXMgbm90IGNoYW5nZSB3aGVuIHRoZQorCQkq
IHJlZ3VsYXRvciBjb3JlIGVuYWJsZXMgdGhlIHJlZ3VsYXRvciAoYW5kIHRodXMgdGhlIFBXTQor
CQkqIGNoYW5uZWwpIGFuZCB0aGVyZSdzIG5vIGNoYW5nZSB0byB0aGUgZHV0eSBjeWNsZSBiZWNh
dXNlIHRoZQorCQkqIHZvbHRhZ2UgdGhhdCBpcyBhY2hpZXZlZCB3aXRoIGEgZGlzYWJsZWQgUFdN
IGlzIGFscmVhZHkgdGhlCisJCSogZGVzaXJlZCBvbmUuCisJCSovCisJCWRydmRhdGEtPnB3bV9z
dGF0ZS5kdXR5X2N5Y2xlID0gMDsKIAogCXJlZ3VsYXRvciA9IGRldm1fcmVndWxhdG9yX3JlZ2lz
dGVyKCZwZGV2LT5kZXYsCiAJCQkJCSAgICAmZHJ2ZGF0YS0+ZGVzYywgJmNvbmZpZyk7Cg==
--000000000000694344061af5d7be--

