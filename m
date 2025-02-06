Return-Path: <linux-pwm+bounces-4808-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74205A2B1DE
	for <lists+linux-pwm@lfdr.de>; Thu,  6 Feb 2025 19:58:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A15633A608E
	for <lists+linux-pwm@lfdr.de>; Thu,  6 Feb 2025 18:58:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AA3F1A0BE1;
	Thu,  6 Feb 2025 18:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bjiEPYyE"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8642919F41C;
	Thu,  6 Feb 2025 18:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738868235; cv=none; b=M2Nvg8fA1JKfxH1YjgOwFHnRZwzrJd0puFwXII6VQmu9UxA+Jlaxny7cxH9/q/HFDXakNsSgwyUqyGxbIvyb+TvyhrO6AZS2PgmBXM0RkwIMU4ZHst4fKyJp1QuJBFc5glrW0i444Q6nbacFC6NFP4TAV4PCGP7zD/gEMgDDf1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738868235; c=relaxed/simple;
	bh=ICTHLkNI8uenWV7g6R/GrB177W+ZTQCmPi0pt+LPgqM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ha2k0iaksi4cOYfG37mc9t2jRYzise5hX/FUT0yCG75kWo/+Qg+0sV6LJ5ka6LZ6mwAho6ZvYRV46RKGtNJE0qYaL22ChX4sBLAamU0XFgLi8tkhc7a8/CbQECW7WCqbhYIAJVrlRCeivqYXnEdXZ6SwDFnurgrFaJjK/PHIYrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bjiEPYyE; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2f43d17b0e3so2254374a91.0;
        Thu, 06 Feb 2025 10:57:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738868233; x=1739473033; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=82K+z0ceVWUKcAwS9weEhngLkfHESnW14b0aAwDilfQ=;
        b=bjiEPYyEMLCc+gsEMQarbo5pLU0sxZyVqE5TrhkgYiDoy+GqaUYgYU3LAPxLIrhzaD
         j57+UyDfK+MgoaDsKjKZB5OjS5uGLkqQ4moZSsabIfJ2KiPW4XDUc/lNTAfy3bt3Qa9W
         EK8HIGTGzjwcBXwbFtZ9Z+yY2CKyu8DjEGzrIyYd6EWRiPShDOZOf+ZHY0B3wTlX4nmv
         MU2NoaRTYv+pHI5FJ1qBYKOF3Wt3Tt2SgQ2R+WpwBo8Ul0HErXEaZcg/fkuvwhJ/FaoX
         AdSjOvGsTrbsr3OgLpO22uyds9wWUP9scWey7lj41D+ZCJar9R/2qdx/YZdfuRxg2X4X
         1Sgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738868233; x=1739473033;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=82K+z0ceVWUKcAwS9weEhngLkfHESnW14b0aAwDilfQ=;
        b=wwTj47tHNdfnHenWqII3CqDTdQZ+hKEnNz3S3tHGHJh1BKCxWoKm9fhB1iHlNs2LmY
         8qySihRK3JRgxptDMd0FBMPMhdwcWyjVgg4Ub3jEr7GBrjvQp4eHghuPpCgvkGK4j56s
         ur57LuyyUinm+0LSXueKIR70T0Dv/8fLDPZ1uCPADuS0sHRWTKq0GZ9wtNMHWgxM+H7G
         D6yXLaMj0gziSdagqCHpvErlVv8SywKxp8RRLaor0z4FwjHwIaogUwG7+TSvCYj7MlHm
         hBy+0pot6i65joZXWTpqX/7hskjMBTF4q1zIb9dXwy8+h3eMcbKdTlw3tAE/HBfYAtJE
         9a3g==
X-Forwarded-Encrypted: i=1; AJvYcCVR7IvB2HblHyQrmLUrBeixe6l+w0FzTKHbhUBB7SafsmXIcb5ElYdr7zFI2KzQaz7bzz1j8d/eSoJjlIZq@vger.kernel.org, AJvYcCVT12fusF2bz5u9kkWzTtuF4Elcdbs/sIl3GTy9aVtcBWUabM7i/djYZNFe6bjowzC6oRDlLhSnvimRkQ==@vger.kernel.org, AJvYcCX8n6jtjVaPweiaJqgakx8/IWHAH4KX/na5MtGlzVJCI3dpWvNkCPZAaTUjzV2uUJc6MVVZdNDjrKOyCRMJe0RfaQHXhg==@vger.kernel.org, AJvYcCXdiOe7IJjJbyhZ5ZFtUu1tqpw4A+Nz6TYOSPMnR6RNIrOB+cHwVSeaafYPqd9yqS6M0ugyAEukeoOd@vger.kernel.org
X-Gm-Message-State: AOJu0YzFRIqD67Kb/V2MQolmy/g4ZBdEdLJ8qStRMJ5czMZvMWjWm/aK
	UP0mGI41mP936cWoJB9Uc/F+BgZNKCUPoPin+jB6kXVmlw7AwKWdW2okYA==
X-Gm-Gg: ASbGncuISp5mERCNTs+EBubsYhNs1GDKc9zJjFxLIyg1Nz2t9ni5IWp+vMbXoMdLK7P
	9kKJjnziwUC9FUhIeS1LG8sMi8zsxn1AGZAay93uL731R2qtaIGBVVU6jvkZ46g3R1VtoYRoOer
	np5noXY6I8Y+gjkw2TUQQYu6nynbnurDxONLGdiZ5kgTMrYV7LXOKTBGiXv7ZAGVlrz4y96xS44
	4WymSUzKJygFpeZB92d4WD/gsdTJ9xrcSXs7BfmhtqvgHUlgGRyaqM3GBpptFIUY3r1LwJ4Wq8o
	iIZKvbo33dmAl9WqWYXqduoQ+Gnw
X-Google-Smtp-Source: AGHT+IFN/hC89p8LJjykf6EKYdtkVx3YVsEozRNXXkCoj639HLrRZRD4vGCcVwU8AJEe7FeaJHu4tQ==
X-Received: by 2002:a17:90b:3ec9:b0:2ee:9b2c:3253 with SMTP id 98e67ed59e1d1-2fa243fc606mr199914a91.30.1738868232501;
        Thu, 06 Feb 2025 10:57:12 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21f3687c8f7sm16353975ad.178.2025.02.06.10.57.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2025 10:57:11 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Thu, 6 Feb 2025 10:57:10 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Werner Sembach <wse@tuxedocomputers.com>
Cc: hdegoede@redhat.com, ilpo.jarvinen@linux.intel.com, ukleinek@kernel.org,
	jdelvare@suse.com, linux-kernel@vger.kernel.org,
	platform-driver-x86@vger.kernel.org, linux-pwm@vger.kernel.org,
	linux-hwmon@vger.kernel.org
Subject: Re: [RFC PATCH 1/1] platform/x86/tuxedo: Implement TUXEDO TUXI ACPI
 TFAN via hwmon
Message-ID: <8f0a9bd6-52dd-442f-b0fd-73cf7028d9f0@roeck-us.net>
References: <20250205162109.222619-1-wse@tuxedocomputers.com>
 <20250205162109.222619-2-wse@tuxedocomputers.com>
 <767538f2-d79e-44e4-a671-4be56a3cfe44@roeck-us.net>
 <fce7929b-87e7-4c9a-8a54-ab678c5dc6b4@tuxedocomputers.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fce7929b-87e7-4c9a-8a54-ab678c5dc6b4@tuxedocomputers.com>

On Thu, Feb 06, 2025 at 10:28:01AM +0100, Werner Sembach wrote:

[ ... ]

> > > +        temp = retval * 100 - 272000;
> > > +
> > > +        for (j = 0; temp_levels[j].temp; ++j) {
> > > +            temp_low = j == 0 ? -272000 : temp_levels[j-1].temp;
> > > +            temp_high = temp_levels[j].temp;
> > > +            if (driver_data->temp_level[i] > j)
> > > +                temp_high -= 2000; // hysteresis
> > > +
> > > +            if (temp >= temp_low && temp < temp_high)
> > > +                driver_data->temp_level[i] = j;
> > > +        }
> > > +        if (temp >= temp_high)
> > > +            driver_data->temp_level[i] = j;
> > > +
> > > +        temp_level = driver_data->temp_level[i];
> > > +        min_speed = temp_level == 0 ?
> > > +            0 : temp_levels[temp_level-1].min_speed;
> > > +        curr_speed = driver_data->curr_speed[i];
> > > +        want_speed = driver_data->want_speed[i];
> > > +
> > > +        if (want_speed < min_speed) {
> > > +            if (curr_speed < min_speed)
> > > +                write_speed(dev, i, min_speed);
> > > +        } else if (curr_speed != want_speed)
> > > +            write_speed(dev, i, want_speed);
> > > +    }
> > > +
> > > +    schedule_delayed_work(&driver_data->work, TUXI_SAFEGUARD_PERIOD);
> > > +}
> > 
> > This is not expected functionality of a hardware monitoring driver.
> > Hardware monmitoring drivers should not replicate userspace or
> > thermal subsystem functionality.
> > 
> > This would be unacceptable in drivers/hwmon/.
> 
> Problem is: The thermal subsystem doesn't do this either as far as I can tell.
> 
> See this: https://lore.kernel.org/all/453e0df5-416b-476e-9629-c40534ecfb72@tuxedocomputers.com/
> and this: https://lore.kernel.org/all/41483e2b-361b-4b84-88a7-24fc1eaae745@tuxedocomputers.com/
> thread.
> 
> The short version is: The Thermal subsystem always allows userspace to
> select the "userspace" governor which has no way for the kernel to enforce a
> minimum speed.
> 
You can specify thermal parameters / limits using devicetree. Also, drivers
can always enforce value ranges.

> As far as I can tell the Thermal subsystem would require a new governor for
> the behavior i want to archive and more importantly, a way to restrict which
> governors userspace can select.
> 
> As to why I don't want grant userspace full control: The firmware is
> perfectly fine with accepting potentially mainboard frying settings (as
> mentioned in the cover letter) and the lowest level I can write code for is
> the kernel driver. So that's the location I need to prevent this.
> 

It is ok for the kernel to accept and enforce _limits_ (such as lower and upper
ranges for temperatures) when they are written. That is not what the code here
does.

> Also hwmon is not purely a hardware monitoring, it also allows writing
> fanspeeds. Or did I miss something and this shouldn't actually be used?
> 

If doesn't actively control fan speeds, though. It just tells the firmware what
the limits or target values are.

> > 
> > Personally I think this is way too complicated. It would make much more sense
> > to assume a reasonable maximum (say, 16) and use fixed size arrays to access
> > the data. The is_visible function can then simply return 0 for larger channel
> > values if the total number of fans is less than the ones configured in the
> > channel information.
> Didn't know it was possible to filter extra entries out completely with the
> is_visible function, thanks for the tip.
> > 
> > Also, as already mentioned, there is no range check of fan_count. This will
> > cause some oddities if the system ever claims to have 256+ fans.
> Will not happen, but i guess a singular additional if in the init doesn't
> hurt, i can add it.

You are making the assumption that the firmware always provides correct
values.

I fully agree that repeated range checks for in-kernel API functions are
useless. However, values should still be checked when a value enters
the kernel, either via userspace or via hardware, even more so if that value
is used to determine, like here, the amount of memory allocated. Or, worse,
if the value is reported as 32-bit value and written into an 8-byte variable.

> > 
> > > +    *hwmdev = devm_hwmon_device_register_with_info(&pdev->dev,
> > > +                               "tuxedo_nbxx_acpi_tuxi",
> > > +                               driver_data, &hwminfo,
> > > +                               NULL);
> > > +    if (PTR_ERR_OR_ZERO(*hwmdev))
> > > +        return PTR_ERR_OR_ZERO(*hwmdev);
> > > +
> > Why not just return hwmdev ?
> because if hwmon is NULL it is still an error, i have to look again at what
> actually is returned by PTR_ERR_OR_ZERO on zero.

That seems a bit philosophical. The caller would have to check for
PTR_ERR_OR_ZERO() instead of checking for < 0.

On a side note, the code now returns 0 if devm_hwmon_device_register_with_info()
returned NULL.  devm_hwmon_device_register_with_info() never returns NULL,
so that doesn't make a difference in practice, but, still, this should
at least use PTR_ERR().

Guenter

