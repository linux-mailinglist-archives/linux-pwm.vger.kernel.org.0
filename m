Return-Path: <linux-pwm+bounces-5629-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 352B9A95135
	for <lists+linux-pwm@lfdr.de>; Mon, 21 Apr 2025 14:45:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC92318939D1
	for <lists+linux-pwm@lfdr.de>; Mon, 21 Apr 2025 12:45:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D848C265615;
	Mon, 21 Apr 2025 12:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GrFMLU77"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 942FB264FBC;
	Mon, 21 Apr 2025 12:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745239507; cv=none; b=ZbrjjeU6qmL2060Cilq6Z37AplRM/XsSNbMIdoc5Yh5hsaWrNaBMcqtCOT87AAsSBYWXhaYZx216ihlNc0X7wnJ/E3xDM/7FzpOHyCziwetNA4TnzYUlVuiJ2cbbxp6+SZJV95LeHZMqlGxRWMuo5/9xq1OIHtESABwQI1EnA9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745239507; c=relaxed/simple;
	bh=nRThIm4QiiJ7kuGTaVkNpVUEQAd1ECcV9p7e7chNtEs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=M0RwYnxJ7slJE2DUGCxO73tRfT1lzL/aegE/olTlUUvj8bmZV6nRJZ0gazYIiFDsBl+KThMoxsCvSCRKffL+WtUMjNgiPznZ/2n8ZupmO4RQgd3sQYB+Osm03ZPH1GOjepna12zMhRxBIEl7rYYNySr4AMzQ2igr7K5axSqZgbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GrFMLU77; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43cef035a3bso26970905e9.1;
        Mon, 21 Apr 2025 05:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745239504; x=1745844304; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nRThIm4QiiJ7kuGTaVkNpVUEQAd1ECcV9p7e7chNtEs=;
        b=GrFMLU77hFPx5PHJConusN1taLnEW3T41kCGxh81+yzgRYmsyYvvhexDHhGih1Slww
         i7mZsUEdAnuCE7Mhdwt282S+Rn4BcSgY1IQX5lRRIVSZ/HIwphL8K5hyEvZqXgzg6DXh
         HlR5RLTufS/q2iBzhAjmd3Z6jhlfiGW9Lrna1f5K2Qoyq98077S0zNupKAfv/pmIrCSj
         OTtSt7dtLVwHi3GmTT0n/w2U8bAacQZn/JCjED86PUrH6CcQJYeub0Pi/pILX0+9gjdq
         SgeVUarN3CIHzyklTFe51squKoanWydUL9zy9wPV3sKXZnIL+ISudUrkhzyd1PccOT8i
         b6Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745239504; x=1745844304;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nRThIm4QiiJ7kuGTaVkNpVUEQAd1ECcV9p7e7chNtEs=;
        b=hsHchfw7TMM036Uegt9sxPmtqRdrEcwJ1U8vPshxEzbsQWlu2J++VhjZO4EUwQNAvE
         nUBhshCE6BQ8sH3xWMRGCwJl1kAxJAhhDs1sL8TsU+C/xEowHnL8SxbxOhd0wJoRsZiO
         RdwWbvd3z4hDnEATyJ0V+TITy8mFJHE/1vbTVXZsfO8GJqKMv/3Xj3AzTseU9Atiz0IH
         CexU9H45h6KyR2SszDrCI3F2zj//oqxG+/racrWPIUw0Rur769Ug1B72eXI3CKT2zJ9s
         n5m5u3Nqc5ENhv5KBABbwuDHodAfD9KKdh1W2Jz7J/ucl1C/lLml3g6VwMimC6x8oqLo
         PyOQ==
X-Forwarded-Encrypted: i=1; AJvYcCUZsAgK+PLTMUM+i0yTsWqlDybLlnRzTxZbP7mI7TpZv4gRp6RDSKttOyR7SQg/VVvoRApN7fGvg8cd@vger.kernel.org, AJvYcCVfkSfAIEqkZ4ahxhgEij+7NYv10wnHyJjp5jmiZ+jbGCxuWV+zGJhS5KYILGK9483kl8WlEeQX1J0qbg==@vger.kernel.org, AJvYcCXMJwDQ7TaN0paZCEB5Z6E3vX47cVodrKB7j3LWLRITpirdGERI00LSpV6OpPIpROa2VqthOiDoTIK3gxw=@vger.kernel.org, AJvYcCXzzzH72//d4tRubesLNYYPqYAnzvfyxod5owt9Gk5h3K5WAQ1HekpK4FRLi/kbkVTEBqhHfFDNPI5j@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3E2Ui98/MHbQdbwx+tX6Aw/cwAXSeMrUusoKwTlhrvDRvRXWH
	Qo6uLeZEhB1hwKz9aO3SvrJcl+hHoI55QXaEImqjMLWR8TB4bjXf
X-Gm-Gg: ASbGnctQtrHbFFJIwN8GQ+emmIkkY3hSXkeIaIBGD6BGhtXeROZCBUl+ZO2ILsWMu83
	7WUzbBCp4/OS24K5kuB72kMTHOpMooZKMXIikI1YPpBapFFYHNqV15/2DqjlDhw42Gi/wCustVJ
	yyFOcdGAXorgoZoZN1EgaIfIdzHoHpjEHJihn7E9vPqNyCtHjreZf1z78gWsoHvK1XMPWvQYKSR
	FRnI0EIFzylM7X3EWVsIXIiG2Z4Qncwx+iihGk4MIBC4Hfr7WIpJvNXb/ii3Q6Xu1GVQ0BhC2tD
	AQcOOUNfJxB+TnQ05JD/XymQZ/T7ciFWWEMH8oLcYTBB++asOauWBXwh5BKB4Nq96nxlcRkRaQg
	WDv/omnnyzBzv
X-Google-Smtp-Source: AGHT+IHX5sZDtw2J4O+0VuZUCUrvhbTSUb9QlVlmfhGWgqrjSCURjxngX+0/EESTIEO7EsSTWHd7Rw==
X-Received: by 2002:a5d:5c84:0:b0:390:f394:6271 with SMTP id ffacd0b85a97d-39efbae066bmr9450052f8f.43.1745239503762;
        Mon, 21 Apr 2025 05:45:03 -0700 (PDT)
Received: from ?IPv6:2001:818:ea8e:7f00:2575:914:eedd:620e? ([2001:818:ea8e:7f00:2575:914:eedd:620e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39efa4235dasm11622069f8f.9.2025.04.21.05.45.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Apr 2025 05:45:03 -0700 (PDT)
Message-ID: <ca9b9fb77e4308fbb2042d49188162d494568835.camel@gmail.com>
Subject: Re: [PATCH v2 01/17] dt-bindings: mfd: adp5585: ease on the
 required properties
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: nuno.sa@analog.com, linux-gpio@vger.kernel.org,
 linux-pwm@vger.kernel.org, 	devicetree@vger.kernel.org,
 linux-input@vger.kernel.org, Lee Jones <lee@kernel.org>,  Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>,  Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?=	
 <ukleinek@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Bartosz
 Golaszewski <brgl@bgdev.pl>, Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Liu Ying <victor.liu@nxp.com>
Date: Mon, 21 Apr 2025 13:45:06 +0100
In-Reply-To: <20250421122929.GA32759@pendragon.ideasonboard.com>
References: <20250415-dev-adp5589-fw-v2-0-3a799c3ed812@analog.com>
	 <20250415-dev-adp5589-fw-v2-1-3a799c3ed812@analog.com>
	 <20250421085605.GA29968@pendragon.ideasonboard.com>
	 <66dd1d165df00d271491a6a5d2a8beaa25f7aec6.camel@gmail.com>
	 <20250421122929.GA32759@pendragon.ideasonboard.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.0 
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-04-21 at 15:29 +0300, Laurent Pinchart wrote:
> On Mon, Apr 21, 2025 at 01:12:33PM +0100, Nuno S=C3=A1 wrote:
> > On Mon, 2025-04-21 at 11:56 +0300, Laurent Pinchart wrote:
> > > On Tue, Apr 15, 2025 at 03:49:17PM +0100, Nuno S=C3=A1 via B4 Relay w=
rote:
> > > > From: Nuno S=C3=A1 <nuno.sa@analog.com>
> > > >=20
> > > > It is not mandatory to use all the capabilities of the device. One =
can
> > > > very well only use it as a gpio controller without the PWM support.=
 This
> > > > will be even more evident when support for the matrix keymap is add=
ed.
> > > > Hence drop the requirements for PWM and GPIO.
> > >=20
> > > This seems to make sense.
> > >=20
> > > Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > >=20
> > > I however expected changes in this series to *not* register MFD cells
> > > for the devices not enabled in DT. Could you do so in v3, on top of t=
his
> > > patch ?
> >=20
> > Makes sense... In theory, I would go with MFD_CELL_OF() but that would =
need
> > (I
> > guess) bindings for all the devices and since PWM and GPIO were not
> > introduced
> > with that...
>=20
> I initially designed the bindings with child nodes, but got told to
> instead use a single DT node :-(
>=20

Interesting, I would expect the child nodes approach to be encouraged...

> > Anyways, I'll look into some "mandatory" property for each of the suppo=
rted
> > cells and use that as deciding point.
>=20
> Sounds good to me.
>=20
> > > > Signed-off-by: Nuno S=C3=A1 <nuno.sa@analog.com>
> > > > ---
> > > > =C2=A0Documentation/devicetree/bindings/mfd/adi,adp5585.yaml | 3 --=
-
> > > > =C2=A01 file changed, 3 deletions(-)
> > > >=20
> > > > diff --git a/Documentation/devicetree/bindings/mfd/adi,adp5585.yaml
> > > > b/Documentation/devicetree/bindings/mfd/adi,adp5585.yaml
> > > > index
> > > > ee2272f754a339569c793102928ddd13249f8fee..e30e22f964f78519b2ec207e9=
415e4
> > > > 897d
> > > > b5c702 100644
> > > > --- a/Documentation/devicetree/bindings/mfd/adi,adp5585.yaml
> > > > +++ b/Documentation/devicetree/bindings/mfd/adi,adp5585.yaml
> > > > @@ -52,9 +52,6 @@ patternProperties:
> > > > =C2=A0required:
> > > > =C2=A0=C2=A0 - compatible
> > > > =C2=A0=C2=A0 - reg
> > > > -=C2=A0 - gpio-controller
> > > > -=C2=A0 - "#gpio-cells"
> > > > -=C2=A0 - "#pwm-cells"
> > > > =C2=A0
> > > > =C2=A0allOf:
> > > > =C2=A0=C2=A0 - if:

