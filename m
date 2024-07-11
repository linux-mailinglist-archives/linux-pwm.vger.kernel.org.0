Return-Path: <linux-pwm+bounces-2770-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BAB4F92F266
	for <lists+linux-pwm@lfdr.de>; Fri, 12 Jul 2024 00:59:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F7201F224C0
	for <lists+linux-pwm@lfdr.de>; Thu, 11 Jul 2024 22:59:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 276D085956;
	Thu, 11 Jul 2024 22:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="GSmJMHE8"
X-Original-To: linux-pwm@vger.kernel.org
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E06441A071C
	for <linux-pwm@vger.kernel.org>; Thu, 11 Jul 2024 22:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720738784; cv=none; b=S1qcQRt+VSfYTacq/t1LMPbiUlKQq+zRBC3Oke3q/E1YBgK/1deicaJiIPU3r8ruItuv2rQTyoytwZv5Je0Minnk3CxIajYBC3YEPPe875q1nHZCkI+Mlka9voh0EeTYuwp6HG5mHh9bvCMqtwdaRl++ZdpLAscgNFHqplQt3Mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720738784; c=relaxed/simple;
	bh=1w3AKH9EN0Wx9MD0cTBXA2kFEOGo0pQZKRLTrIYTgsg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i/2xbGpRy5/+gt1Ann8EDD92+bzfVQghD/3bKhoTycYj/dXaIkEzCyzgxwmAH6FrC7NFObJDW++usj34wbqgvRAjhrOQbtBtEXamRWVZu+iIN2c18zWvM1JX5OZ81AIx2FVokL1I1ItDunQ5+gybgueU04M5Lt0rzEGcu1zHn3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=GSmJMHE8; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 74E652C0132;
	Fri, 12 Jul 2024 10:59:38 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1720738778;
	bh=MHVDaPGK/QMOD6P3TiMBGa1kYC6k4UkPb0F0BCu/HbM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=GSmJMHE8epDzwfmZlTW5gMVq0BFJClLSPRyXJDOBGI+QoGO0Zu0/zTGyavUUNm34X
	 aN/cMlNsjd930qcWrjY9Px6LVUwtx86KOn4oiQonMqUcm1Ubpb4e90VhrMCDmAOLlN
	 jldoDOgKOw8VXqXQeLnDHxVGgU/fWNKI6jUlgT18yPHTTiMLFMGQtI7/UP1Bz1BY3Y
	 D/+psADuakPAlu1QP8TcvQ39f0rm7m3LIZDpQ5aFUZfWSmqCWBAM4MtJOqxHra6raT
	 9jdiXlulppDqT2E4kfYNVeX5ij3Wt1rfUBi+v60s0jTTNUn/H0zUpu21VXQE4+zdvO
	 g5kTlMDwzcr+g==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B669063da0000>; Fri, 12 Jul 2024 10:59:38 +1200
Received: from [10.33.22.30] (chrisp-dl.ws.atlnz.lc [10.33.22.30])
	by pat.atlnz.lc (Postfix) with ESMTP id 48B1D13EE2B;
	Fri, 12 Jul 2024 10:59:38 +1200 (NZST)
Message-ID: <d44a6621-49ff-41c3-a4c1-69bf2e92e012@alliedtelesis.co.nz>
Date: Fri, 12 Jul 2024 10:59:38 +1200
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH v4 1/3] dt-bindings: hwmon: Add adt7475 fan/pwm properties
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: jdelvare@suse.com, linux@roeck-us.net, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, linux-hwmon@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pwm@vger.kernel.org
References: <20240528225638.1211676-1-chris.packham@alliedtelesis.co.nz>
 <20240528225638.1211676-2-chris.packham@alliedtelesis.co.nz>
 <drqvaon5lb2ei3jqofutbr6demibyfdhbmr24sva27gzpqdnon@fxa7rpl33iih>
Content-Language: en-US
From: Chris Packham <chris.packham@alliedtelesis.co.nz>
In-Reply-To: <drqvaon5lb2ei3jqofutbr6demibyfdhbmr24sva27gzpqdnon@fxa7rpl33iih>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.4 cv=PIKs+uqC c=1 sm=1 tr=0 ts=669063da a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=IkcTkHD0fZMA:10 a=4kmOji7k6h8A:10 a=txvsxk6BNV_vTGTgBH0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-SEG-SpamProfiler-Score: 0
x-atlnz-ls: pat

Hi Uwe,

On 5/07/24 21:09, Uwe Kleine-K=C3=B6nig wrote:
> Hello Chris,
>
> sorry for taking so long to respond. Don't take it personal, I'm way
> behind my maintainer dutys in general.
>
> On Wed, May 29, 2024 at 10:56:36AM +1200, Chris Packham wrote:
>> Add fan child nodes that allow describing the connections for the
>> ADT7475 to the fans it controls. This also allows setting some
>> initial values for the pwm duty cycle and frequency.
>>
>> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
>> ---
>>
>> Notes:
>>      I realise there is still some discussion about how to express the
>>      frequency and duty cycle. I have a personal preference for using =
hertz
>>      for the frequency and 0-255 for the duty cycle but if the consens=
us is
>>      to express these things some other way I'm fine with doing some m=
ath.
>>     =20
>>      Changes in v4:
>>      - 0 is not a valid frequency value
>>      Changes in v3:
>>      - Use the pwm provider/consumer bindings
>>      Changes in v2:
>>      - Document 0 as a valid value (leaves hardware as-is)
>>
>>   .../devicetree/bindings/hwmon/adt7475.yaml    | 25 +++++++++++++++++=
+-
>>   1 file changed, 24 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/devicetree/bindings/hwmon/adt7475.yaml b/Do=
cumentation/devicetree/bindings/hwmon/adt7475.yaml
>> index 051c976ab711..bfef4c803bf7 100644
>> --- a/Documentation/devicetree/bindings/hwmon/adt7475.yaml
>> +++ b/Documentation/devicetree/bindings/hwmon/adt7475.yaml
>> @@ -51,6 +51,15 @@ properties:
>>         enum: [0, 1]
>>         default: 1
>>  =20
>> +  "#pwm-cells":
>> +    const: 4
>> +    description: |
>> +      Number of cells in a PWM specifier.
>> +      - 0: The pwm channel
>> +      - 1: The pwm frequency in hertz - 11, 14, 22, 29, 35, 44, 58, 8=
8, 22500
> Nack, don't deviate from how PWMs are usually referenced. So specify th=
e
> period in nanoseconds, not Hertz.

OK no problem. The math is easy enough. I might end up over documenting=20
things for the acceptable PWM period so someone can weigh in on that.

>> +      - 2: PWM flags 0 or PWM_POLARITY_INVERTED
>> +      - 3: The default pwm duty cycle - 0-255
> I'd be ok with that, however please add support for that in the pwm cor=
e
> and then just use that.
>
> You wrote that you find it irritating that the duty is specified in
> nanoseconds and not a percentage. The reason for that is historic. Also
> it gives a more precise specification (at least compared to the naive
> representation of the integer percentage as an integer type).
> For the rework of how PWM waveforms are represented I picked
> "duty_length" as variable name for this value, in the hope this is less
> confusing.
>
> untested prototype for a 4th member in pwm specifiers:

Right now the adt7475 is not a pwm_chip and I'm not really planning on=20
making it one. My goal with this was just to make it possible for the=20
kernel to keep the fans running quietly before userland can take over=20
and start doing proper configuration/monitoring. The best I can do is=20
make sure that the devicetree binding is done in such a way that it=20
could grow pwm_chip capabilities in the future.

>
> diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
> index 5c1d20985148..f732235df12d 100644
> --- a/drivers/pwm/core.c
> +++ b/drivers/pwm/core.c
> @@ -251,7 +251,7 @@ int pwm_adjust_config(struct pwm_device *pwm)
>   	 * duty cycle of 0.
>   	 */
>   	if (!state.period) {
> -		state.duty_cycle =3D 0;
> +		state.duty_cycle =3D pargs.duty_length;
>   		state.period =3D pargs.period;
>   		state.polarity =3D pargs.polarity;
>  =20
> @@ -437,6 +437,10 @@ of_pwm_xlate_with_flags(struct pwm_chip *chip, con=
st struct of_phandle_args *arg
>   	if (args->args_count > 2 && args->args[2] & PWM_POLARITY_INVERTED)
>   		pwm->args.polarity =3D PWM_POLARITY_INVERSED;
>  =20
> +	pwm->args.duty_length =3D 0;
> +	if (args->args_count > 3)
> +		pwm->args.duty_length =3D args->args[3];
> +
>   	return pwm;
>   }
>   EXPORT_SYMBOL_GPL(of_pwm_xlate_with_flags);
> @@ -457,6 +461,10 @@ of_pwm_single_xlate(struct pwm_chip *chip, const s=
truct of_phandle_args *args)
>   	if (args->args_count > 1 && args->args[1] & PWM_POLARITY_INVERTED)
>   		pwm->args.polarity =3D PWM_POLARITY_INVERSED;
>  =20
> +	pwm->args.duty_length =3D 0;
> +	if (args->args_count > 2)
> +		pwm->args.duty_length =3D args->args[2];
> +
>   	return pwm;
>   }
>   EXPORT_SYMBOL_GPL(of_pwm_single_xlate);
> @@ -1353,6 +1361,9 @@ static struct pwm_device *acpi_pwm_get(const stru=
ct fwnode_handle *fwnode)
>   	if (args.nargs > 2 && args.args[2] & PWM_POLARITY_INVERTED)
>   		pwm->args.polarity =3D PWM_POLARITY_INVERSED;
>  =20
> +	/* Maybe extend this to apply args.args[3] if args.nargs > 3? */
> +	pwm->args.duty_cycle =3D 0;
> +
>   	return pwm;
>   }
>  =20
> @@ -1514,6 +1525,7 @@ struct pwm_device *pwm_get(struct device *dev, co=
nst char *con_id)
>  =20
>   	pwm->args.period =3D chosen->period;
>   	pwm->args.polarity =3D chosen->polarity;
> +	pwm->args.duty_length =3D 0;
>  =20
>   	return pwm;
>   }
> diff --git a/include/linux/pwm.h b/include/linux/pwm.h
> index f8c2dc12dbd3..678a97706eac 100644
> --- a/include/linux/pwm.h
> +++ b/include/linux/pwm.h
> @@ -41,6 +41,7 @@ enum pwm_polarity {
>    */
>   struct pwm_args {
>   	u64 period;
> +	u32 duty_length;
>   	enum pwm_polarity polarity;
>   };
>  =20
> (I think it doesn't make sense to use a u64 here. At least the oftree
> values are only 32 bit wide. I didn't check the ACPI part, if that is
> only 32 bit wide, too, it would make sense to make period use a 32 bit
> type, too.)
>
> Best regards
> Uwe

