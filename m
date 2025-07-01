Return-Path: <linux-pwm+bounces-6635-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C782AEFAF8
	for <lists+linux-pwm@lfdr.de>; Tue,  1 Jul 2025 15:42:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 313CE7AC7E0
	for <lists+linux-pwm@lfdr.de>; Tue,  1 Jul 2025 13:41:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CAA2274B37;
	Tue,  1 Jul 2025 13:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QgJoN4Ck"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43A7424466E;
	Tue,  1 Jul 2025 13:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751377360; cv=none; b=cZ0gclyDXo8zqSH2bJBJbQqwSJjGleLj3iUl+Cz0wqXDh1FxKXDJZ6hhpYfBw+OJxM4xBMY6Yv7kiTd8+oPwLIkxvzdLhwIsf2YTxGy90D07hUDmAxdZodI0hOTL7OxuBPaLb2RoBIkb0xAAuUv1rby3ZgQvf6oCMX53EYz4f6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751377360; c=relaxed/simple;
	bh=zEPKwaxizYmJFZbCuGJfe81nb4alVm8Vf9gWeFFK+to=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pOMsoUCbfcZaCsAKnRCTBH8DdlanfXeFxmw6b8uaW6eSvTjYAjJl1MlljLKOZNghhnFJRYUE+a2g8wFoXdui6Mw0bV80WQnvlOztu+VJqoxq+Pg6Z340kRJNJyPmYmAFrXy5s2cRjyZpvC3dg313HALpuCDEdivn8AJXCXn8tDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QgJoN4Ck; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3a548a73ff2so5047103f8f.0;
        Tue, 01 Jul 2025 06:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751377356; x=1751982156; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zEPKwaxizYmJFZbCuGJfe81nb4alVm8Vf9gWeFFK+to=;
        b=QgJoN4Ck87QYv9ZBZQhf6jl/PJcw13BerDEX0wAQwO7/NWAMgZrpRVpQKBE4kTdnbN
         6LiCQRuoHMaJVekB9wv5o6Kc7qXrWZdjdoF8wHamS/t6JUrCRX993BG73goy8hD2G3Q5
         BgDdxQKLqU4dTroC8DqKB8Vj2QS09DypIipi9D+EB2qcUN7I2ols6+ntYsDJaGArBFeT
         p75bLX7yYaZJcPEAYiAPxIsv72gLzDpJyn2kKvsYPaGsQYnonwUCtkIi5uroT3AKvpuF
         uALkYi38eHILmfA+G6w/EEYrcjyWAwhuCZSEbBydxEfqS6YudCACqrng2QuyOrKNGn8V
         T7RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751377356; x=1751982156;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zEPKwaxizYmJFZbCuGJfe81nb4alVm8Vf9gWeFFK+to=;
        b=FUCCojFIVGZjgxDLFBwrY7cEyPFRJLPTdQ8KmErzw6XLi9jAlLyeIy26H2SwMvb1+f
         Hvv8awP/JBjw7LnBxJoBFND2cbjkpoDqCk6mbUF/DvOPORBOcs492mYLHwwTbh8FzL3j
         iMna9BVlVAbR24J3pOClXQjnJslvZGkbFXL0/VKmRKRSUzH/e/9aQzSOPlerxt96yBZ6
         W7p952KGDHSCmOA3CdILvHhw/5SU/8o0OOevLY27tj7hOggR7MmN029MrNGjTeE716FO
         IyodvKhaOfoc9ui8zMk85ZAQ5jw8+Fjxic3wUJtuwMCavZY0abz7X1GmTN3XSCycsP/W
         uPvw==
X-Forwarded-Encrypted: i=1; AJvYcCV4tjCU7hCYQ2Xcsept+4zgXlwdNoxI5pJC9YSCDgOL0J4to2y7zZsTOEHWlbeIBE2jJdOrC5gV4OrKwQ==@vger.kernel.org, AJvYcCVSdBe8P3s8Yu0R6rPxds8H6+zR3ZwlwR43+usdkE3W/BJBBaSV7+89U2/jP9Iu2R4ykOo9BZ3p0Jzg@vger.kernel.org, AJvYcCVd6NBu9tRg2Rvr5gA+sEbVQ+h47gbDu+AS9NirccU00Gf/yBfeNN1LCoc3xJ4pso7y0wG7WeJEYAhc@vger.kernel.org, AJvYcCXfhDptxDcltGjNMNDFLY4sOrreutWna+LmfXo5hs2Q7PqxVNher7HSU+KN9yu3op+e2qGBgMxM734MBD8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxApGuaxMDKfSysppUoVG02pLG624MasIZgIry67F5KsiqPCGYF
	oqSIBguyfeCgBXwTPbA484goO/KSjQfMVNSG0wJclF5wDd+9C+oNFPQE
X-Gm-Gg: ASbGncs3CBs6yUdQ0bt4tW+aHEzAKu37A13a7KHd9Ack/DrrHHLv+ieyhpnAjileB/U
	mj9dfTKLHojr3sqWkISsTQIk13CflwrUbG8ikrWq6p2Ox/c2LsMx91Jiq+tmH70EXqa6VX7Qemc
	Or7WTXLqQN1Mne4wqx/9R5Yc3LZKozhYgA/dK4hijuEvR1hWfJJgFNAQtGuXtkTJUbBtCJa3JCC
	KQSeB6KoQsoni+htYcgGRFmDDHI0OH5c7Ufx+duau7lSyI6n4wNCYzV0yWBqg4uXJ4NPov9xEAC
	MT4j+VDk0GTNyGgVQe5R/8XTcBl6+CKFDG/0m4v+skBA2tTQYOY7KvxTQxjacmE1oL5I6A==
X-Google-Smtp-Source: AGHT+IESuCDJf6vslKrCMWWqWUvCb2mBDoVf2rcdTueuIcYkfVuN7pOkhii6idRhbM7v/S7vj6mHDw==
X-Received: by 2002:a05:6000:104e:b0:3a4:f513:7f03 with SMTP id ffacd0b85a97d-3a917bc827cmr12426455f8f.44.1751377356141;
        Tue, 01 Jul 2025 06:42:36 -0700 (PDT)
Received: from [192.168.1.187] ([161.230.67.253])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4538a3a6716sm167153435e9.11.2025.07.01.06.42.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 06:42:35 -0700 (PDT)
Message-ID: <d60c08a3b518e12c8fc0d0eba4ed208aafa8ca82.camel@gmail.com>
Subject: Re: [PATCH v5 00/20] mfd: adp5585: support keymap events and drop
 legacy Input driver
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Lee Jones <lee@kernel.org>, Laurent Pinchart
	 <laurent.pinchart@ideasonboard.com>
Cc: nuno.sa@analog.com, linux-gpio@vger.kernel.org,
 linux-pwm@vger.kernel.org, 	devicetree@vger.kernel.org,
 linux-input@vger.kernel.org, Rob Herring	 <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley	 <conor+dt@kernel.org>, Uwe
 =?ISO-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,  Linus Walleij
 <linus.walleij@linaro.org>, Bartosz Golaszewski <brgl@bgdev.pl>, Dmitry
 Torokhov	 <dmitry.torokhov@gmail.com>, Liu Ying <victor.liu@nxp.com>,
 Bartosz Golaszewski	 <bartosz.golaszewski@linaro.org>, Krzysztof Kozlowski	
 <krzysztof.kozlowski@linaro.org>
Date: Tue, 01 Jul 2025 14:42:46 +0100
In-Reply-To: <20250701133732.GO10134@google.com>
References: <20250614-dev-adp5589-fw-v5-0-7e9d84906268@analog.com>
	 <20250619133834.GC795775@google.com>
	 <d20682874dbd65acde8b80efa004706a09b23248.camel@gmail.com>
	 <20250701110522.GK10134@google.com>
	 <15ba1febb0f0acf4057af64c5c84db0633cab864.camel@gmail.com>
	 <20250701111948.GK15184@pendragon.ideasonboard.com>
	 <20250701133732.GO10134@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-07-01 at 14:37 +0100, Lee Jones wrote:
> On Tue, 01 Jul 2025, Laurent Pinchart wrote:
>=20
> > On Tue, Jul 01, 2025 at 12:09:11PM +0100, Nuno S=C3=A1 wrote:
> > > On Tue, 2025-07-01 at 12:05 +0100, Lee Jones wrote:
> > > > On Fri, 27 Jun 2025, Nuno S=C3=A1 wrote:
> > > >=20
> > > > > On Thu, 2025-06-19 at 14:38 +0100, Lee Jones wrote:
> > > > > > On Sat, 14 Jun 2025, Nuno S=C3=A1 via B4 Relay wrote:
> > > > > >=20
> > > > > > > Hi all,
> > > > > > >=20
> > > > > > > Here it goes v4. Main changes is to drop chip info based stru=
ct
> > > > > > > and
> > > > > > > directly use an enum in the FW .data pointer, use the notifie=
r API
> > > > > > > for
> > > > > > > dispatching events and multiple calls to mfd_add_devices().
> > > > > > >=20
> > > > > > > Regarding the last point, I think I could have used multiple =
calls
> > > > > > > to
> > > > > > > devm_mfd_add_devices() and avoid those gotos in
> > > > > > > adp5585_add_devices()
> > > > > > > but I do not feel that would have been "correct".
> > > > > > >=20
> > > > > > > Thanks!
> > > > > > > - Nuno S=C3=A1
> > > > > > >=20
> > > > > > > ---
> > > > > > > Changes in v5:
> > > > > >=20
> > > > > > In future, these should be inside the patches themselves please=
.
> > > > >=20
> > > > > Hi Lee,
> > > > >=20
> > > > > I'm about to send v6. I just have a question regarding the above.=
 Do
> > > > > you
> > > > > mean to
> > > > > have the log in the commit message itself like DRM or do it with =
git
> > > > > notes?
> > > >=20
> > > > I have no idea what git notes is.
> > >=20
> > > It pretty much adds a note before the diff stat but with an annoying
> > > "Notes:"
> > > line. b4 seems to ignore it anyways.
> > >=20
> > > > Simply place the Changelog inside the patch, just above the diff st=
at.
> > >=20
> > > There's already some emails about this on v6. I ended up doing it DRM
> > > style
> > > because tweaking the patch before sensing is surprisingly non trivial=
 with
> > > b4.
> > > Unless I missed something.
> >=20
> > You can record the changelog in the commit message below a=20
> >=20
> > ---
> >=20
> > line asyou modify commits. That way you won't have to write the
> > changelogs when sending the patches, and b4 should not cause any issue.
>=20
> Exactly this.=C2=A0 Should be easy enough.

Yes, just checked now. I was being mistaken by the fact that doing the abov=
e
while changing commits will still locally display on my 'git log'. But it w=
ill
then be discarded when you apply the patches.

I'll send v7 with the changelog fixed.

- Nuno S=C3=A1

