Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A1ED5BE8AB
	for <lists+linux-pwm@lfdr.de>; Tue, 20 Sep 2022 16:21:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231760AbiITOV1 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 20 Sep 2022 10:21:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231764AbiITOVE (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 20 Sep 2022 10:21:04 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4249C11C12;
        Tue, 20 Sep 2022 07:19:27 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id bh13so2782855pgb.4;
        Tue, 20 Sep 2022 07:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date;
        bh=VXEcIbQ0V8hEk0noSkT2sAeiDRQ27pxVdSWGQHxmOR8=;
        b=BuQhEA/1zqL7jbiYk7lGlAKEoQJ/v6+FUT8v5qyPLygKrcUMV5UatNhNfIhzfDilLx
         TzYmki3eD72o+jXiV15GzgCNFstPqvZ8SrwSff3Cuyc5DC9NR3JU5A1IEppqQlKZQydq
         b+EyU7ZzH11/TIME4DFcy8dKFTcfg1gxVYqxsEYHqZISLa/aCLjuSd4FGCR6RdUwtstM
         YZmQYhUDGN4whIPwRp2dXQjSKgGS9i6/lQo775p9wU1ZRreZ2V2ybD0HPr/ra03BPMdZ
         rIDngSQikEemcZyFeAMy2+hOYyjnGOoPSFI7xncdZKcsItc0vjtzIdfRekG5qyt7creV
         UshA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date;
        bh=VXEcIbQ0V8hEk0noSkT2sAeiDRQ27pxVdSWGQHxmOR8=;
        b=bD0sDEasp3ilDbjKI2ujDSZAvwAMWS+ljo5nz7Qi3UvqEU+t464bqyU916mdd1X/62
         zEBueucOYFO1LtHYx+8fy8wFsEDMBdVteUvhH53ANWY2MAerIOIl98x30vxyJvqGDlX6
         z4NE8MjE7NX9OdsJwfthmG+RebZ8rRMo6Y4UqRElXLtLmD1lThpFIxIrXnbDKkqH+8WN
         nR/ysgdSabXiA/VnEvUccgY37jvKANllcjrQnV8peBNRqLsj6NADbb7sYZ48WSs13LW2
         OSJZv4qNBWppr4uRg+oPU5B6SA1vHBi7T3brxm2OPvM1W/OPA/9ZdtMdCpG78DSX/7NZ
         J8+g==
X-Gm-Message-State: ACrzQf22Hf2zdY0138+uVt1OnIhu6OfdrPbeoiiev5zul7f2lO10LGod
        4m3WvE6gesbD2YHrorODCK8=
X-Google-Smtp-Source: AMsMyM6uyU4QFzZfvHH7IpAVwGwKKuVXxlTZ7GQvQ580Av6M9yiYRu0K0jegV/M4rABQ6NSQNEFm3g==
X-Received: by 2002:a05:6a00:1248:b0:548:2e34:65e1 with SMTP id u8-20020a056a00124800b005482e3465e1mr24047061pfi.82.1663683566642;
        Tue, 20 Sep 2022 07:19:26 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id a2-20020a1709027e4200b001754fa42065sm1517011pln.143.2022.09.20.07.19.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Sep 2022 07:19:26 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 20 Sep 2022 07:19:25 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Alexander Stein <alexander.stein@ew.tq-group.com>
Cc:     Jean Delvare <jdelvare@suse.com>, Jonathan Corbet <corbet@lwn.net>,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        linux-hwmon@vger.kernel.org, linux-pwm@vger.kernel.org,
        Markus Niebel <Markus.Niebel@ew.tq-group.com>
Subject: Re: [PATCH v5 4/5] hwmon: pwm-fan: split __set_pwm into
 locked/unlocked functions
Message-ID: <20220920141925.GA3684684@roeck-us.net>
References: <20220914153137.613982-1-alexander.stein@ew.tq-group.com>
 <20220914153137.613982-5-alexander.stein@ew.tq-group.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220914153137.613982-5-alexander.stein@ew.tq-group.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Wed, Sep 14, 2022 at 05:31:36PM +0200, Alexander Stein wrote:
> Regular calls to set_pwm don't hold the mutex, but the upcoming
> update_enable support needs to call set_pwm with the mutex being held.
> So provide the previous behavior in set_pwm (handling the lock), while
> adding __set_pwm which assumes the lock being held.
> 
> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> Reviewed-by: Guenter Roeck <linux@roeck-us.net>

Applied to hwmon-next.

Thanks,
Guenter
