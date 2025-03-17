Return-Path: <linux-pwm+bounces-5203-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 66F15A6475D
	for <lists+linux-pwm@lfdr.de>; Mon, 17 Mar 2025 10:30:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82343164F5C
	for <lists+linux-pwm@lfdr.de>; Mon, 17 Mar 2025 09:30:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BB9F221F18;
	Mon, 17 Mar 2025 09:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XQqDGFA/"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57FBC133987;
	Mon, 17 Mar 2025 09:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742203837; cv=none; b=cVnOmEOEMJjNVjMZbkKKOwukUGDz6RgUSORSgy4AL8BEzwz658tPGS7FMNOmp0QBmZnyV1WFfEqRxrvR4fWsFgrcGZjVihl/v+ObFHl6y13ZMZYkDmS9GLZRk4sRix0d6x05beSXh1k6iCMh9MFrSKdn2rOp+stsDQlMoM73Vv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742203837; c=relaxed/simple;
	bh=qhhkurOO1/r/FUzk14/TdKBO8AXtyjU2NgmH4MtYBt4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WZayaYHgwDCEu8NLHjJuys87iedt640GmpTz205j+rd9okX9H6Qv2LsZHXJjAp29+AnTG8ZoM7aV4aTPlsPXhX4yDl2fYKnHSkbTNo74H0iroS05LY/5+J5j8hMQmyu8jfW/kOZWF30KhcPt+5wYF4cnn17C5FkCnwEW5/Bpbls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XQqDGFA/; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-390cf7458f5so3628221f8f.2;
        Mon, 17 Mar 2025 02:30:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742203832; x=1742808632; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=eig1iFcSepoHSxapZeehFNku7IVWpcgwRa3rcpt4M5U=;
        b=XQqDGFA/5CQere/6/1YS2zgzVWNHR5+vqYPWHl9MlLrtQ60ki/uaN4G7dn8IQofybW
         Mb+WPly4p5ZuDL0hlRCDmzZTpm/uwA4yXdTzhSpSZjV0kHHFmh6U0SMl+DTjwlRe8Kan
         yU6PkJv3o2q1OZowZrv3CWKO74z3Le0uILCQKjXMgle2qW7AFHRfkKQu3mVT6m1Iz0bn
         ecXpQQ+C0JKfBbLXZc3DWyV6ifym/3rgoSeiNGbOGUMrIBgYCvmqrjdFZwKgBsDgs1pH
         QgNdl2Ene34rxqX9m1EJJjgQHl7JQNEIlUtImcFgpzs8MKeB8tk3OdajErqlgdRG/HiD
         Et7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742203832; x=1742808632;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eig1iFcSepoHSxapZeehFNku7IVWpcgwRa3rcpt4M5U=;
        b=DmkxMp/GTGhTL1DnKH4JiiR9JNCXKkCBgQPmoX5/pe7vvNUveKHUsSmBNz0qWEcQq/
         X/+7UZWg9pAkqrVUYA4m/dAkBohR1XE0urYkTSieE7hwgD6WiW1dRqe/MkbFU1F/Qgsx
         oaVCk/ZxhFLu5sWxRfs9skucYPe5UL4FiIApxM0fcnhoHlRT1Z8qS2C1d4EDteX/1VaX
         B0HJKI/pRBc3cduU2Su+2Lnb149DZklONvfZe+jwXotBXcotL5ZuJ+XlRh5xzkXxguID
         4gJ3RzisuHn/ywfPaun8RxAkcEn60Q0qERlX+kNEybwRuSDGE0qdYEN55bvzR547H8zk
         VpnQ==
X-Forwarded-Encrypted: i=1; AJvYcCV5wxGiT5OKEgdjiQtK7vOGoMpcOgcpJjXUS6hsAO/XyX2W++WTcH5Twob5Ecvq5i4dWa9hiohCAmB5@vger.kernel.org, AJvYcCWnoJKhuOwTCz7xmjF5ORANqDcws5pOeUMbuwc+5PkSU2iE6bqkYU73gkAVx1PN6tbP6qZLf5Ujo2f3oTs=@vger.kernel.org, AJvYcCX+OqppIL7P3RS3jCRCUjNl7RgQlgvWobRAjm2cwTMF5+hSxK5yEyKa7gEXZq2s+lIQqpoKDoBgKjtp@vger.kernel.org
X-Gm-Message-State: AOJu0Ywz7phetZrsF5XZwRibPsj2WTlRUhWcun+kTpWPqXb/y9RV9vUK
	OujaCY5oMOc29Jrvpp8Nvgme3u6nFe4B83JVXd7QiS1Uxu/QGsF5lWgWyo5CUJg=
X-Gm-Gg: ASbGncvNQrpGDyG6uXc/FiVhF2TD+5NUflq6l8VNQRXJcoZPEsJF9QAzi2FqyHe2qmp
	Z9TAd8jGop3KCt10CfCyyGCnkPiio36mlEPgcrn359n9CRI5mFg0ihqtuIClHKK0ZwoF+jYfB8P
	alseYzJ5YcaKKgrnETV9Fa+h7f/Xj4iewhzaDlygwnwJG1fvPxpU6Dp+gAdyk5tgMXqm5mTSg0N
	7SOt36zD6oI/zutOR+dlrxWap3rwCKlj7YKA2NcGwTnxuBErv5KybbGDuvhuXSsGZzUyCwEMOTY
	gMv9wGMIsFjzY6nSMU+Qg++ywMJx7Kn4aA+ERlQkt19tBB45UXYRMa9ZUkX2pWUxX8FzhKz6ibP
	9iLvX5xmRixcwclHg
X-Google-Smtp-Source: AGHT+IHZsuR0ksLjZ4G7uF6NVcvU+eKQUxiFAy9W0UbHlBwE5CRiQBUmT4llbb7TORGwpiUiTLd8Hw==
X-Received: by 2002:a5d:47ae:0:b0:391:a43:8bbd with SMTP id ffacd0b85a97d-3971e876615mr13523314f8f.21.1742203832369;
        Mon, 17 Mar 2025 02:30:32 -0700 (PDT)
Received: from ?IPv6:2001:818:ea8e:7f00:2575:914:eedd:620e? ([2001:818:ea8e:7f00:2575:914:eedd:620e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395c7df3506sm14803542f8f.11.2025.03.17.02.30.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 02:30:31 -0700 (PDT)
Message-ID: <ae74d31e8b3874da91ec5c2c9a20274358073266.camel@gmail.com>
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
Date: Mon, 17 Mar 2025 09:30:37 +0000
In-Reply-To: <f1ccbdc1-3f47-46a8-bcc2-ca6135882392@kernel.org>
References: <20250313-dev-adp5589-fw-v1-0-20e80d4bd4ea@analog.com>
	 <20250313-dev-adp5589-fw-v1-5-20e80d4bd4ea@analog.com>
	 <20250314-outstanding-futuristic-cat-5d8240@krzk-bin>
	 <c59477b2a94cbd10bc530809fbcdc0f2d1b79d07.camel@gmail.com>
	 <f1ccbdc1-3f47-46a8-bcc2-ca6135882392@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-03-17 at 08:41 +0100, Krzysztof Kozlowski wrote:
> On 14/03/2025 10:38, Nuno S=C3=A1 wrote:
> > On Fri, 2025-03-14 at 09:49 +0100, Krzysztof Kozlowski wrote:
> > > On Thu, Mar 13, 2025 at 02:19:22PM +0000, Nuno S=C3=A1 wrote:
> > > > =C2=A0=C2=A0 reg:
> > > > =C2=A0=C2=A0=C2=A0=C2=A0 maxItems: 1
> > > > @@ -63,13 +70,26 @@ allOf:
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 properties:
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 gpio-reserved-rang=
es: false
> > > > =C2=A0=C2=A0=C2=A0=C2=A0 else:
> > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 properties:
> > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 gpio-reserved-ranges:
> > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 maxItems: 1
> > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 items:
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if:
> > >=20
> > > Do not nest if:then:else:if:then, it leads to code impossible to read=
.
> > > Just provide if-then cases for each of your variant.
> > >=20
> >=20
> > Alright...
> >=20
> > >=20
> > >=20
> > >=20
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 properties:
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 compatible:
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 contains:
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 enum:
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 - adi,adp5585-00
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 - adi,adp5585-02
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 - adi,adp5585-03
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 - adi,adp5585-04
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 then:
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 properties:
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 gpio-reserv=
ed-ranges:
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 maxItems: 1
> > >=20
> > > one tem?
> > >=20
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 items:
> > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 - const: 5
> > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 - const: 1
> > >=20
> > > But here two...
> > >=20
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 items:
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 - const: 5
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 - const: 1
> > >=20
> > > and this is confusing. I don't get what you want to express.
> > >=20
> >=20
> > I just kept it as before (maybe I messed up in some other way but the 2
> > items:
>=20
> No, your code is very different.
>=20
> > were already in the binding):
>=20
> I see only one GPIO range.
>=20
> >=20
> > https://elixir.bootlin.com/linux/v6.14-rc6/source/Documentation/devicet=
ree/bindings/mfd/adi,adp5585.yaml#L70
> >=20
> > If this is not needed I can simplifying during this patch. Is this
> > sufficient?
> >=20
> > ...
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 gpio-reserved-ranges:
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 maxItems: 1
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 items:
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - co=
nst: 5
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - co=
nst: 1
>=20
> Again, different code and not correct as you have now two ranges. Open
> original code - it is clear not the same. So two tries - your patch and
> code above - are different but I don't get why you claim your code is
> identical.
>=20

I'm really missing something obvious but how is it different? The original =
code
was:

- if:
      properties:
        compatible:
          contains:
            const: adi,adp5585-01
    then:
      properties:
        gpio-reserved-ranges: false
    else:
      properties:
        gpio-reserved-ranges:
          maxItems: 1
          items:
            items:
              - const: 5
              - const: 1

Now, I have:

- if:
      properties:
        compatible:
          contains:
            const: adi,adp5585-01
    then:
      properties:
        gpio-reserved-ranges: false
    else:
      if:
        properties:
          compatible:
            contains:
              enum:
                - adi,adp5585-00
                - adi,adp5585-02
                - adi,adp5585-03
                - adi,adp5585-04
      then:
        properties:
          gpio-reserved-ranges:
            maxItems: 1
            items:
              items:
                - const: 5
                - const: 1
      else:
        properties:
          gpio-reserved-ranges: false


So the only thing I have is the nested 'if else' (that you already complain=
ed
about) and I need to have 'gpio-reserved-ranges: false' for the adp5589 fam=
ily
of devices since there is no such constrain. But this part:

properties:
  gpio-reserved-ranges:
    maxItems: 1
    items:
      items:
        - const: 5
        - const: 1

is very much what we have today.

So, sorry if I'm missing something obvious but I'm really not getting what =
you
mean...

- Nuno S=C3=A1



