Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 227F87BB5D6
	for <lists+linux-pwm@lfdr.de>; Fri,  6 Oct 2023 13:04:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231962AbjJFLED (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 6 Oct 2023 07:04:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232047AbjJFLD4 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 6 Oct 2023 07:03:56 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 792A4FB
        for <linux-pwm@vger.kernel.org>; Fri,  6 Oct 2023 04:03:54 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-9ae75ece209so376794566b.3
        for <linux-pwm@vger.kernel.org>; Fri, 06 Oct 2023 04:03:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696590233; x=1697195033; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2P6VrI0Vd/slBGYP2H9W09Mrw4vmULqNqcfS9qnQRQo=;
        b=DAo1lVXtyVg57jfvVrsCqryyJobQq23g9pwmOkSQbB9xVDyys31Wb8W7VmAHHHouRX
         iWdl4mD8In6odYsI0UVS/NpVwa2H0SkK05k6ZvDBUgLBWJPnjcAJ8tEX5MLwgYC+33F+
         mNYOq6LRecmR4ln1F1OXAexJfMewG45mjVMwYRAIpi5ByKXryf7agCu2IvffLK2w+pxh
         mLe/HaOAnKjPdZdcadzqu3kSwtzMq7hMf5u5PcAIcO8qqKiIeG/LeVgVZG4KmZCnQGRX
         /qlLNLMAY3Ka9s/eKOEUJG3wZjzx8O5Z0Y7ofhl0MZ8XsosuH5TLiHFQfwSetNQ7cbrN
         w7pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696590233; x=1697195033;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2P6VrI0Vd/slBGYP2H9W09Mrw4vmULqNqcfS9qnQRQo=;
        b=i3ltTi2tcqmwLyAWqi0Rw6SXEqXaAqQiiwAFsT8VuRvDS1pX0Zs+HD2u0I7gF8XJ1f
         9l5fOSKBQqA8Khv1pwJGz3Q+qDWaAgKVoukuMaC61ezWOtBGc9OZSFPCF5sABAkytfn7
         kLd2icwenPB28VZLOwk37clX7JSZYeCCPIHQpCvmKV55rdSb/AdTX2MBS6yUxxaDukiU
         RLvWTjlY9FsnRgiYl8NzYdB2Pu5lt7FCiAiD0jA7TMSwd3f7fkHWFegftjwfL4pul2ph
         cZB7ZQvIM8W5hxTRVbn8rys3wgCn40G8q9+C/rx72b/DgSJzwct0TYlwYeB3O25hod3P
         hsAg==
X-Gm-Message-State: AOJu0Yy3aQdj53TBcegZN0Tv73gfD1hOuqi9L+mhFZtUnoWbZ0e5fqm5
        hsr8EhKfjKMT92DYrwprzxDYkqeSAAo=
X-Google-Smtp-Source: AGHT+IEpMNpl7nprhj5lg85QttHmuxvH+vzKPMyCXfZopJ8W+DRbvBddeb/GQONOF2SgKGoogIw+ZA==
X-Received: by 2002:a17:906:319a:b0:9a5:9f8d:770 with SMTP id 26-20020a170906319a00b009a59f8d0770mr7199289ejy.46.1696590232659;
        Fri, 06 Oct 2023 04:03:52 -0700 (PDT)
Received: from orome.fritz.box (p200300e41f3f4900f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f3f:4900:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id 17-20020a170906059100b00992f2befcbcsm2644547ejn.180.2023.10.06.04.03.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 04:03:52 -0700 (PDT)
Date:   Fri, 6 Oct 2023 13:03:50 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH 1/2] pwm: Change how pwm_chip IDs are determined
Message-ID: <ZR_pltZCN1fRjfBB@orome.fritz.box>
References: <20230808165250.942396-1-u.kleine-koenig@pengutronix.de>
 <20230808165250.942396-2-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="gf6wQ+HoVGQQ3oc1"
Content-Disposition: inline
In-Reply-To: <20230808165250.942396-2-u.kleine-koenig@pengutronix.de>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--gf6wQ+HoVGQQ3oc1
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 08, 2023 at 06:52:49PM +0200, Uwe Kleine-K=C3=B6nig wrote:
> Traditionally each PWM device had a unique ID stored in the "pwm" member
> of struct pwm_device. However this number was hardly used and dropped in
> the previous commit. Further the unique ID of a PWM chip matched the ID
> of the first contained PWM device.

This is slightly confusing. The PWM chip "base" was never supposed to be
an ID and its usage in sysfs was more of an accident than actual
purpose. The primary purpose of it was to serve as the base number of
pins in the global number space, but with that number space gone, there
is no use for the base number anymore.

So I think changing the subject to something like this would be better:

	pwm: Replace PWM chip unique base by unique ID

> With the PWM device ID gone PWM chips can get their IDs better and
> simpler using an idr.
>=20
> This is expected to change the numbering of PWM chips, but nothing
> should rely on the numbering anyhow.
>=20
> Other than that the side effects are:
>=20
>  - The PWM chip IDs are smaller and in most cases consecutive.
>  - The ordering in /sys/kernel/debug/pwm is ordered by ascending PWM
>    chip ID.
>=20
> Also use "id" as name for the PWM chip ID which better matches the new
> semantic of that number.
>=20
> For the plan to introduce support for pwmchip character devices this
> also simplifies getting the struct pwm_chip matching a given PWM chip ID
> (or character device).

Again, it would be interesting to see how this would work in practice.
As things are this is pure speculation, so I'd leave out this comment.

> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/pwm/core.c  | 67 +++++++++++++++++----------------------------
>  drivers/pwm/sysfs.c |  2 +-
>  include/linux/pwm.h |  3 +-
>  3 files changed, 27 insertions(+), 45 deletions(-)
>=20
> diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
> index dc66e3405bf5..9b1eb37e2e73 100644
> --- a/drivers/pwm/core.c
> +++ b/drivers/pwm/core.c
> @@ -8,6 +8,7 @@
> =20
>  #include <linux/acpi.h>
>  #include <linux/module.h>
> +#include <linux/idr.h>
>  #include <linux/of.h>
>  #include <linux/pwm.h>
>  #include <linux/list.h>
> @@ -23,52 +24,25 @@
>  #define CREATE_TRACE_POINTS
>  #include <trace/events/pwm.h>
> =20
> -#define MAX_PWMS 1024
> -
>  static DEFINE_MUTEX(pwm_lookup_lock);
>  static LIST_HEAD(pwm_lookup_list);
> =20
> -/* protects access to pwm_chips and allocated_pwms */
> +/* protects access to pwmchip_idr */
>  static DEFINE_MUTEX(pwm_lock);
> =20
> -static LIST_HEAD(pwm_chips);
> -static DECLARE_BITMAP(allocated_pwms, MAX_PWMS);
> -
> -/* Called with pwm_lock held */
> -static int alloc_pwms(unsigned int count)
> -{
> -	unsigned int start;
> -
> -	start =3D bitmap_find_next_zero_area(allocated_pwms, MAX_PWMS, 0,
> -					   count, 0);
> -
> -	if (start + count > MAX_PWMS)
> -		return -ENOSPC;
> -
> -	bitmap_set(allocated_pwms, start, count);
> -
> -	return start;
> -}
> -
> -/* Called with pwm_lock held */
> -static void free_pwms(struct pwm_chip *chip)
> -{
> -	bitmap_clear(allocated_pwms, chip->base, chip->npwm);
> -
> -	kfree(chip->pwms);
> -	chip->pwms =3D NULL;
> -}
> +DEFINE_IDR(pwmchip_idr);

static? I would probably have kept the same pwm_chips as well. We
already know that this is an IDR given the type, so no need to repeat
that.

>  static struct pwm_chip *pwmchip_find_by_name(const char *name)
>  {
>  	struct pwm_chip *chip;
> +	unsigned long id, tmp;
> =20
>  	if (!name)
>  		return NULL;
> =20
>  	mutex_lock(&pwm_lock);
> =20
> -	list_for_each_entry(chip, &pwm_chips, list) {
> +	idr_for_each_entry_ul(&pwmchip_idr, chip, tmp, id) {
>  		const char *chip_name =3D dev_name(chip->dev);
> =20
>  		if (chip_name && strcmp(chip_name, name) =3D=3D 0) {
> @@ -278,14 +252,14 @@ int pwmchip_add(struct pwm_chip *chip)
> =20
>  	mutex_lock(&pwm_lock);
> =20
> -	ret =3D alloc_pwms(chip->npwm);
> +	ret =3D idr_alloc(&pwmchip_idr, chip, 0, 0, GFP_KERNEL);
>  	if (ret < 0) {
>  		mutex_unlock(&pwm_lock);
>  		kfree(chip->pwms);
>  		return ret;
>  	}
> =20
> -	chip->base =3D ret;
> +	chip->id =3D ret;
> =20
>  	for (i =3D 0; i < chip->npwm; i++) {
>  		pwm =3D &chip->pwms[i];
> @@ -295,8 +269,6 @@ int pwmchip_add(struct pwm_chip *chip)
>  		pwm->hwpwm =3D i;
>  	}
> =20
> -	list_add(&chip->list, &pwm_chips);
> -
>  	mutex_unlock(&pwm_lock);
> =20
>  	if (IS_ENABLED(CONFIG_OF))
> @@ -323,11 +295,11 @@ void pwmchip_remove(struct pwm_chip *chip)
> =20
>  	mutex_lock(&pwm_lock);
> =20
> -	list_del_init(&chip->list);
> -
> -	free_pwms(chip);
> +	idr_remove(&pwmchip_idr, chip->id);
> =20
>  	mutex_unlock(&pwm_lock);
> +
> +	kfree(chip->pwms);
>  }
>  EXPORT_SYMBOL_GPL(pwmchip_remove);
> =20
> @@ -623,10 +595,11 @@ EXPORT_SYMBOL_GPL(pwm_adjust_config);
>  static struct pwm_chip *fwnode_to_pwmchip(struct fwnode_handle *fwnode)
>  {
>  	struct pwm_chip *chip;
> +	unsigned long id, tmp;
> =20
>  	mutex_lock(&pwm_lock);
> =20
> -	list_for_each_entry(chip, &pwm_chips, list)
> +	idr_for_each_entry_ul(&pwmchip_idr, chip, tmp, id)
>  		if (chip->dev && device_match_fwnode(chip->dev, fwnode)) {
>  			mutex_unlock(&pwm_lock);
>  			return chip;
> @@ -1085,17 +1058,27 @@ static void pwm_dbg_show(struct pwm_chip *chip, s=
truct seq_file *s)
> =20
>  static void *pwm_seq_start(struct seq_file *s, loff_t *pos)
>  {
> +	unsigned long id =3D *pos;
> +	void *ret;
> +
>  	mutex_lock(&pwm_lock);
>  	s->private =3D "";
> =20
> -	return seq_list_start(&pwm_chips, *pos);
> +	ret =3D idr_get_next_ul(&pwmchip_idr, &id);
> +	*pos =3D id;
> +	return ret;
>  }
> =20
>  static void *pwm_seq_next(struct seq_file *s, void *v, loff_t *pos)
>  {
> +	unsigned long id =3D *pos + 1;
> +	void *ret;
> +
>  	s->private =3D "\n";
> =20
> -	return seq_list_next(v, &pwm_chips, pos);
> +	ret =3D idr_get_next_ul(&pwmchip_idr, &id);
> +	*pos =3D id;
> +	return ret;
>  }
> =20
>  static void pwm_seq_stop(struct seq_file *s, void *v)
> @@ -1105,7 +1088,7 @@ static void pwm_seq_stop(struct seq_file *s, void *=
v)
> =20
>  static int pwm_seq_show(struct seq_file *s, void *v)
>  {
> -	struct pwm_chip *chip =3D list_entry(v, struct pwm_chip, list);
> +	struct pwm_chip *chip =3D v;
> =20
>  	seq_printf(s, "%s%s/%s, %d PWM device%s\n", (char *)s->private,
>  		   chip->dev->bus ? chip->dev->bus->name : "no-bus",
> diff --git a/drivers/pwm/sysfs.c b/drivers/pwm/sysfs.c
> index 8d1254761e4d..4edb994fa2e1 100644
> --- a/drivers/pwm/sysfs.c
> +++ b/drivers/pwm/sysfs.c
> @@ -510,7 +510,7 @@ void pwmchip_sysfs_export(struct pwm_chip *chip)
>  	 * the kernel it's just not exported.
>  	 */
>  	parent =3D device_create(&pwm_class, chip->dev, MKDEV(0, 0), chip,
> -			       "pwmchip%d", chip->base);
> +			       "pwmchip%d", chip->id);
>  	if (IS_ERR(parent)) {
>  		dev_warn(chip->dev,
>  			 "device_create failed for pwm_chip sysfs export\n");
> diff --git a/include/linux/pwm.h b/include/linux/pwm.h
> index d2f9f690a9c1..09da803bbd46 100644
> --- a/include/linux/pwm.h
> +++ b/include/linux/pwm.h
> @@ -295,7 +295,7 @@ struct pwm_ops {
>  struct pwm_chip {
>  	struct device *dev;
>  	const struct pwm_ops *ops;
> -	int base;
> +	int id;

Why not make this unsigned long while we're at it? Looks like that's the
native type for IDRs and we already make sure that whatever is stored in
here isn't going to be negative.

All of the above are minor changes, so I can fix them up as I apply the
patch, if you don't have any objections.

Thierry

--gf6wQ+HoVGQQ3oc1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmUf6ZQACgkQ3SOs138+
s6FnYRAAtT0FtlnOQXPSFOxW+MfIpAypfDuh7QgcLrPsmOREBoZVm3iDKI1rwYwW
XdcfFlf3u+idWMlNOMJbHx1Q5a2E3NRbGmATeYmb3Izzwzki0d8l5/9x1d8h5Ypb
+8Q1QIYO7gQGyT7L8SadQm2zQDI00m/IPy0cqAF6wla+2+iY1ocel1ZyPQVi1gtg
R42n9t8RzwBhKE5maUpcHfuwg0hLLFv/L+EAsJfS/0OIIgzNJfnao2xjBAfr1eu9
0pVBZYQCEB61U+MXVek87sE2YOZS2h9bvCJxsggFrbL2AFT3BMx64IRGLMBO4wb7
sa73YcWvrQEIPs8zF7wrVpV69yK1zedlm55t/ypzZwd+02P2bTZMsmZDr4TJ4zjK
68byLehlDKZO4bXqhnv5D3A1b+YZG2xyv4sW9qUdMDOgN9LuDQPVqTOVUpUHsJv3
e4DCbI24Aa7xW1zU6uU9O0oxIl4FvI7tEmZTnGANOJXMml/lRfAl5Jyyl7Z32tTu
I/XZ8kumD40fyZ9fic23HV4tllrcOVXIbCYqC54RyDFsKmot6mt5ag3Go989SO5L
OXwiDP4J0rUApoY5WFUOSDQTIVxyvMWKpCVkm3xivcu6FvdMpG/0wMWrzGt2AoSt
uksLBXDO3KXMKbFTlr+ibd8nhcNGWcXxZXLgZ+qsvB7Me6dpJZc=
=0xTq
-----END PGP SIGNATURE-----

--gf6wQ+HoVGQQ3oc1--
