Return-Path: <linux-pwm+bounces-7739-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C8E2C96430
	for <lists+linux-pwm@lfdr.de>; Mon, 01 Dec 2025 09:54:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9C133A1B1B
	for <lists+linux-pwm@lfdr.de>; Mon,  1 Dec 2025 08:54:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 871992F6194;
	Mon,  1 Dec 2025 08:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="vRFwZu4y"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D87331FF1C4
	for <linux-pwm@vger.kernel.org>; Mon,  1 Dec 2025 08:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764579267; cv=none; b=Zc9z8ghuaLYDgEo4VeUtTeWSy0OAwZqhRGy9zZwJNydKV/+1XT2oq0kMTy/LKJ0wFFee7zCebbaXzbhrojdbTVVTBz0ndh1Xg2pIfA3InlieKOogCmEbHFOw88dlP/qifU3Canp3uR6trCgZGgZUdF1175wgrNLqqz8lPKUnBbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764579267; c=relaxed/simple;
	bh=OAxr5rndUE1p71G4GvlaIJ7vknpLMgy0h/ZyMFhryPs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=RZ3MmwlduUj7HyG/m9CYIcwRape/S//S8o4FOpg91yVT53YCaMP5om54FVu61cTHfyUFNIKqr/ezx07ShXAVq+OVwTePn5bFb+/aatW5ZiXHykzC8xTWhCoVjG6KLFKDSoPRcray6jh/sjidWYnBUaFtnHvQJtD3t7wwb74vKpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=vRFwZu4y; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b7633027cb2so505742466b.1
        for <linux-pwm@vger.kernel.org>; Mon, 01 Dec 2025 00:54:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1764579263; x=1765184063; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=j5faQ3nMBeXf/+sW6UR7r18N5IMAq8XFYfUScP7vIOw=;
        b=vRFwZu4yEVO1qFh3yVLhXV+lDAl+LKnH0+AwZk6QmhTXyRbngy1AKNIqc8zjEYlECU
         PibDp2bhourpmkrKqNZ5eBfRM26QgDGfsfEShn72esDKwz7SsriLkN92hM9FMCac+1+t
         zyrepyIXGC9XcugfbRHKAhQR7u+HlX3KFNTZnahDf7HlVQj+Y/wehiwSSb4tFijb5C8z
         pRDneAB/RJ6t+LbBjmD+zlxNmihGi82A714vjY89d3KvIlE283szJ0pREi/2XMR6siuD
         uc6k/YTIUs4v44cSiBVNsnryrAkkNqyeOgWRINzrHS3A4MUnHNX/DjsktrKvI3UPdypf
         CBRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764579263; x=1765184063;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j5faQ3nMBeXf/+sW6UR7r18N5IMAq8XFYfUScP7vIOw=;
        b=q7lT6qelv2gCDxmEVuhMX8PlB0ABVOQgu0OVw6Pn35rmm+foMBWYK1tEcalJfQRhLX
         /NBxDrMSRwGu81CdysNwqY1uhxj7zveTI+yfM3pxcXXYhdC88IsJ+Kj0mmZcr3SFOI5+
         QYFGfgyMk+YsIp5GnoGEl8UCYDfA4XkE1wcvE9vxlobHCdMjtFRPxLmXUtvjkoGW3XLe
         WrGCSl3iIwQZXOm2l1dnO2YUYnP1upKt1jJSEkWmY9udo4MhGx4L+JW/9py+imSgckn6
         uxxozDQ4O0duvqqM8zW3xfwKV+fO5wulubCfP+4HstLBWASLfYXETo9z2gO/xP6HBCLj
         sMZQ==
X-Forwarded-Encrypted: i=1; AJvYcCUaTAisYw0zIG1ui8ZMJddMFb/9ZPSi2tFRYl3u7Q8qlFlDQMQV82mJpRbU03pJEyGD5mRw1mUcu+U=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLFtAu5oG1O4LA99W6TwHPXNO6Pi65rTUKHuMN+sZKmLcIxuwM
	+cZ2YMZGQSxSwY9XhW5HWKSxdBDU+taWWSTrGdd11XghsghnH3hmFOXuujqyEo5rU5E=
X-Gm-Gg: ASbGnctn0VHmMXFtaECT7HHj7VX7iJvKKrPsJ55JOPTfhW7y7VQCEC2Apn1WkHV3v55
	4Ji0G8a4AOFAy5cG1uxbNe65jZop4nT9w3zmxTZOG0YvEnECWf1UBPYRGauKJq95fAvogCPuBin
	XEgehnE7Zjgcjzu0sCrVXPJ0e7Tp/Lt5nF+6B9Jn1kCwOHcgqkY7+188765AMdLtsp4G4kOJg8U
	pbY66WqL4cKwyoExi/naV0vvKq5fwbcKVWs3beFsj6O6so3CFDu9Uze2LoegjN7d4reksn9ct5m
	sEnla324ibtTguXaBtQSHFnTB9Dj3jgBlqYKImfHsFjxz++pAntST3klhkHi/29v8sD+yCHVFue
	3Lyl4yQsiE/b9hVBQ8ulgs2Ml8dMT1kOkzQ4tc4K8uUF47Jj8w25ph0+XbeVuMas8ZmXxo45Pqm
	TixpbrUvyPYFNPOblLeEhy8NdJ/NAa7n980qOP1JhIEK0o4CYQTkI5H8uHEBOABUZh2gx6DKYS1
	iY=
X-Google-Smtp-Source: AGHT+IHh20gCynnmK3c1aZ9tGwOBfy0jp1hGEabDg9sLWyhr9JcH/N3G3GrpRmPFQUuSYOZk0eLJYw==
X-Received: by 2002:a17:906:fe47:b0:b76:2667:7717 with SMTP id a640c23a62f3a-b76718ab19cmr4489495566b.56.1764579263062;
        Mon, 01 Dec 2025 00:54:23 -0800 (PST)
Received: from localhost (p200300f65f0066088b503b97e2761468.dip0.t-ipconnect.de. [2003:f6:5f00:6608:8b50:3b97:e276:1468])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b76f5a265d4sm1161594966b.60.2025.12.01.00.54.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Dec 2025 00:54:22 -0800 (PST)
Date: Mon, 1 Dec 2025 09:54:20 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Daniel Gomez <da.gomez@samsung.com>, linux-pwm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Michal Wilczynski <m.wilczynski@samsung.com>
Subject: [GIT PULL] pwm: Changes for v6.19-rc1
Message-ID: <ew3w7xtjwbsk77bzdjj2fek3z5kzou2su2gdhdn5qqrnboyxgj@sqmo7mn5myes>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="jyluvubzjghhyklc"
Content-Disposition: inline


--jyluvubzjghhyklc
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: [GIT PULL] pwm: Changes for v6.19-rc1
MIME-Version: 1.0

Hello Linus,

the following changes since commit f84fd5bec502447df145f31734793714690ce27f:

  pwm: adp5585: Correct mismatched pwm chip info (2025-11-14 11:55:56 +0100)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git tags/p=
wm/for-6.19-rc1

for you to fetch changes up to fae00ea9f00367771003ace78f29549dead58fc7:

  pwm: rzg2l-gpt: Allow checking period_tick cache value only if sibling ch=
annel is enabled (2025-11-27 09:58:07 +0100)

for the merge window leading to (I guess) 6.19-rc1.

----------------------------------------------------------------
pwm: Changes for v6.19-rc1

Additional to the usual mix of core cleanups, driver changes, minor
fixes and device tree updates the highlight this cycle is Rust support
for the core and a first Rust driver both provided by Michal Wilczynski.
Michal wrote about these changes on
https://mwilczynski.dev/posts/bringing-rust-to-the-pwm-subsystem/ which
is a nice read.

----------------------------------------------------------------

There is a merge conflict with the modules tree, commits=20

	0b24f9740f26 rust: module: update the module macro with module parameter s=
upport
	3809d7a89fe5 rust: module: use a reference in macros::module::module

currently in next. I think there is no pull request for these yet. The
conflict is resolved correctly in next, the resolution is straight
forward apart from moving a & in the last hunk about import_ns which is
a continuation of 3809d7a89fe5 for the changes added in commit
739ad9be61e5 ("rust: macros: Add support for 'imports_ns' to module!").
For reference here is my resolution:

diff --cc rust/macros/module.rs
index 408cd1154875,d62e9c1e2a89..000000000000
--- a/rust/macros/module.rs
+++ b/rust/macros/module.rs
@@@ -98,7 -205,50 +205,51 @@@ struct ModuleInfo=20
      description: Option<String>,
      alias: Option<Vec<String>>,
      firmware: Option<Vec<String>>,
 +    imports_ns: Option<Vec<String>>,
+     params: Option<Vec<Parameter>>,
+ }
+=20
+ #[derive(Debug)]
+ struct Parameter {
+     name: String,
+     ptype: String,
+     default: String,
+     description: String,
+ }
+=20
+ fn expect_params(it: &mut token_stream::IntoIter) -> Vec<Parameter> {
+     let params =3D expect_group(it);
+     assert_eq!(params.delimiter(), Delimiter::Brace);
+     let mut it =3D params.stream().into_iter();
+     let mut parsed =3D Vec::new();
+=20
+     loop {
+         let param_name =3D match it.next() {
+             Some(TokenTree::Ident(ident)) =3D> ident.to_string(),
+             Some(_) =3D> panic!("Expected Ident or end"),
+             None =3D> break,
+         };
+=20
+         assert_eq!(expect_punct(&mut it), ':');
+         let param_type =3D expect_ident(&mut it);
+         let group =3D expect_group(&mut it);
+         assert_eq!(group.delimiter(), Delimiter::Brace);
+         assert_eq!(expect_punct(&mut it), ',');
+=20
+         let mut param_it =3D group.stream().into_iter();
+         let param_default =3D expect_param_default(&mut param_it);
+         let param_description =3D expect_string_field(&mut param_it, "des=
cription");
+         expect_end(&mut param_it);
+=20
+         parsed.push(Parameter {
+             name: param_name,
+             ptype: param_type,
+             default: param_default,
+             description: param_description,
+         })
+     }
+=20
+     parsed
  }
 =20
  impl ModuleInfo {
@@@ -113,7 -263,7 +264,8 @@@
              "license",
              "alias",
              "firmware",
 +            "imports_ns",
+             "params",
          ];
          const REQUIRED_KEYS: &[&str] =3D &["type", "name", "license"];
          let mut seen_keys =3D Vec::new();
@@@ -139,7 -289,7 +291,8 @@@
                  "license" =3D> info.license =3D expect_string_ascii(it),
                  "alias" =3D> info.alias =3D Some(expect_string_array(it)),
                  "firmware" =3D> info.firmware =3D Some(expect_string_arra=
y(it)),
 +                "imports_ns" =3D> info.imports_ns =3D Some(expect_string_=
array(it)),
+                 "params" =3D> info.params =3D Some(expect_params(it)),
                  _ =3D> panic!("Unknown key \"{key}\". Valid keys are: {EX=
PECTED_KEYS:?}."),
              }
 =20
@@@ -179,30 -329,25 +332,30 @@@ pub(crate) fn module(ts: TokenStream) -
      // Rust does not allow hyphens in identifiers, use underscore instead.
      let ident =3D info.name.replace('-', "_");
      let mut modinfo =3D ModInfoBuilder::new(ident.as_ref());
-     if let Some(authors) =3D info.authors {
+     if let Some(authors) =3D &info.authors {
          for author in authors {
-             modinfo.emit("author", &author);
+             modinfo.emit("author", author);
          }
      }
-     if let Some(description) =3D info.description {
-         modinfo.emit("description", &description);
+     if let Some(description) =3D &info.description {
+         modinfo.emit("description", description);
      }
      modinfo.emit("license", &info.license);
-     if let Some(aliases) =3D info.alias {
+     if let Some(aliases) =3D &info.alias {
          for alias in aliases {
-             modinfo.emit("alias", &alias);
+             modinfo.emit("alias", alias);
          }
      }
-     if let Some(firmware) =3D info.firmware {
+     if let Some(firmware) =3D &info.firmware {
          for fw in firmware {
-             modinfo.emit("firmware", &fw);
+             modinfo.emit("firmware", fw);
          }
      }
-     if let Some(imports) =3D info.imports_ns {
++    if let Some(imports) =3D &info.imports_ns {
 +        for ns in imports {
-             modinfo.emit("import_ns", &ns);
++            modinfo.emit("import_ns", ns);
 +        }
 +    }
 =20
      // Built-in modules also export the `file` modinfo string.
      let file =3D

Sorry for that inconvenience.

Please pull this for v6.19-rc1.

Best regards
Uwe


Benjamin Larsson (1):
      pwm: airoha: Add support for EN7581 SoC

Biju Das (1):
      pwm: rzg2l-gpt: Allow checking period_tick cache value only if siblin=
g channel is enabled

Chen Ni (1):
      pwm: mediatek: Remove unneeded semicolon

Mathieu Dubois-Briand (1):
      pwm: max7360: Clean MAX7360 code

Michal Wilczynski (9):
      rust: macros: Add support for 'imports_ns' to module!
      pwm: Export `pwmchip_release` for external use
      rust: pwm: Add Kconfig and basic data structures
      rust: pwm: Add complete abstraction layer
      rust: pwm: Add module_pwm_platform_driver! macro
      pwm: Add Rust driver for T-HEAD TH1520 SoC
      dt-bindings: pwm: thead: Add T-HEAD TH1520 PWM controller
      pwm: th1520: Fix clippy warning for redundant struct field init
      pwm: th1520: Use module_pwm_platform_driver! macro

Miguel Ojeda (2):
      rust: pwm: Fix broken intra-doc link
      pwm: Fix Rust formatting

Uwe Kleine-K=F6nig (8):
      rust: pwm: Drop wrapping of PWM polarity and state
      pwm: Simplify printf to emit chip->npwm in $debugfs/pwm
      pwm: Use %u to printf unsigned int pwm_chip::npwm and pwm_chip::id
      pwm: Drop unused function pwm_apply_args()
      pwm: mediatek: Convert to waveform API
      pwm: mediatek: Make use of struct_size macro
      Merge branch 'pwm/th1520' into pwm/for-next
      pwm: bcm2835: Make sure the channel is enabled after pwm_request()

 .../devicetree/bindings/pwm/thead,th1520-pwm.yaml  |  48 ++
 MAINTAINERS                                        |  10 +
 drivers/pwm/Kconfig                                |  33 +
 drivers/pwm/Makefile                               |   2 +
 drivers/pwm/core.c                                 |   8 +-
 drivers/pwm/pwm-airoha.c                           | 622 +++++++++++++++++
 drivers/pwm/pwm-bcm2835.c                          |  28 +-
 drivers/pwm/pwm-max7360.c                          |   2 +-
 drivers/pwm/pwm-mediatek.c                         | 335 ++++++----
 drivers/pwm/pwm-rzg2l-gpt.c                        |  15 +-
 drivers/pwm/pwm_th1520.rs                          | 387 +++++++++++
 include/linux/pwm.h                                |  39 +-
 rust/bindings/bindings_helper.h                    |   1 +
 rust/helpers/helpers.c                             |   1 +
 rust/helpers/pwm.c                                 |  20 +
 rust/kernel/lib.rs                                 |   2 +
 rust/kernel/pwm.rs                                 | 735 +++++++++++++++++=
++++
 rust/macros/module.rs                              |   8 +
 18 files changed, 2096 insertions(+), 200 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pwm/thead,th1520-pwm.=
yaml
 create mode 100644 drivers/pwm/pwm-airoha.c
 create mode 100644 drivers/pwm/pwm_th1520.rs
 create mode 100644 rust/helpers/pwm.c
 create mode 100644 rust/kernel/pwm.rs


--jyluvubzjghhyklc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmktV7oACgkQj4D7WH0S
/k5PLgf+OPkO9yys1W+ZzSB+XJjAgTULopUIqjIjak2MJO8eYtb1p6VnblEkYiff
RcHKwQJyRSObJZrWY+fGSKIkYb7eWxn3An60+EEi5TBtdvhjlrkhjYrnKu3cwBh1
AWGIOHnEvu3iaHmHB7zKsUuSXi5RWJdFuXwBO3pnrNc40An1BN6cUuDoiHoOF50V
HjeJzcEiVLMxNhBjH4bQ37LWXl0v21sLdZpQDDeEdiBRTYny6e4iV37RsL+Lpwmk
pjpQ9eK9eEOwdWmkk1OGvPBcsswGszsql3D/RmgACSeUiuFjvBlihjzobP5mXwsk
2e/GzJAd7YTz2GveKAAahpHpxbtEjA==
=yXXV
-----END PGP SIGNATURE-----

--jyluvubzjghhyklc--

