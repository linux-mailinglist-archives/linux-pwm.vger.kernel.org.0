Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 528202CC46D
	for <lists+linux-pwm@lfdr.de>; Wed,  2 Dec 2020 18:59:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728615AbgLBR6L (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 2 Dec 2020 12:58:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728414AbgLBR6K (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 2 Dec 2020 12:58:10 -0500
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EDAEC061A04
        for <linux-pwm@vger.kernel.org>; Wed,  2 Dec 2020 09:56:50 -0800 (PST)
Received: by mail-pf1-x443.google.com with SMTP id x24so1723278pfn.6
        for <linux-pwm@vger.kernel.org>; Wed, 02 Dec 2020 09:56:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to;
        bh=eOa4DHct8Xnwdoavh4m1aB8nMCDgTHv3sM8WJcB4XGw=;
        b=U8aqbKfGMLqT3pSxHCPDgvoLdw9QFCOYoe4d9tN+oePeGx6SijhJh5DWzMXsYDNlXj
         laqJxEiL33Rw4oVtKPwREHEjvauujXmOoKgjVVJiilXoRLkWTkm0z64szS+PGN1GeGRl
         OGVrYKcZ2CTmnyDsO55M8vSA8GF/Wf6p2AoE8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to;
        bh=eOa4DHct8Xnwdoavh4m1aB8nMCDgTHv3sM8WJcB4XGw=;
        b=UYRxVD/f9GpZtarlp3TF4yfmqXD+0v67Cnt7rXrlyUn9Pl2TqMZEPDwNTlG0N8geoh
         nsiFysQ6KhwOpdOg3UZYpEo5K0JWiQunk4H3cCAQUCE83fRuBqlXFR3OKqgRR0cLZ5l9
         nNuTKEznBJ/KBW6tYs79GrgmVRO9XX7MAFiAp5lzqgVtJMJDEYaeQ83ppDbtEETCUgh9
         A+1MIhSWiWM0TcBHaoNrM50B/Ghz0+Zccu3XjUlYWZ2sNm3RKhBs/aHYjB6jehaz7gP0
         qmGWeSxLsJGxRwJa2MLndpUO093lAFIFXEqhRgkj11N8/TMhMhf5suOuF6lZyn7eI7ac
         jYFw==
X-Gm-Message-State: AOAM531Ls9uqT9bJOoEHhxckO2F4zmWd1IAAESekm1GngFlXez59BK/v
        16HkfZXAS4RDnasd/f64+BG6lg==
X-Google-Smtp-Source: ABdhPJxBe044BSxWCPiEeTi93ZhPm7YYKKxN40yOk58k6np08WWXwO/od1vrZpNwuxokEC+Wbx0dOQ==
X-Received: by 2002:aa7:9606:0:b029:198:14c4:4f44 with SMTP id q6-20020aa796060000b029019814c44f44mr3903103pfg.80.1606931809755;
        Wed, 02 Dec 2020 09:56:49 -0800 (PST)
Received: from [10.230.28.242] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id a21sm287155pjq.37.2020.12.02.09.56.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Dec 2020 09:56:48 -0800 (PST)
Subject: Re: [PATCH v5 07/11] staging: vchiq: Release firmware handle on
 unbind
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        u.kleine-koenig@pengutronix.de, linux-kernel@vger.kernel.org
Cc:     f.fainelli@gmail.com, linux-pwm@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        wahrenst@gmx.net, linux-input@vger.kernel.org,
        dmitry.torokhov@gmail.com, gregkh@linuxfoundation.org,
        devel@driverdev.osuosl.org, p.zabel@pengutronix.de,
        linux-gpio@vger.kernel.org, linus.walleij@linaro.org,
        linux-clk@vger.kernel.org, sboyd@kernel.org,
        linux-rpi-kernel@lists.infradead.org, bgolaszewski@baylibre.com,
        andy.shevchenko@gmail.com
References: <20201123183833.18750-1-nsaenzjulienne@suse.de>
 <20201123183833.18750-8-nsaenzjulienne@suse.de>
From:   Florian Fainelli <florian.fainelli@broadcom.com>
Message-ID: <3bad2612-6280-b362-8239-493e4cc87509@broadcom.com>
Date:   Wed, 2 Dec 2020 09:56:46 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201123183833.18750-8-nsaenzjulienne@suse.de>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000b9614705b57ef7fb"
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

--000000000000b9614705b57ef7fb
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit



On 11/23/2020 10:38 AM, Nicolas Saenz Julienne wrote:
> Use devm_rpi_firmware_get() so as to make sure we release RPi's firmware
> interface when unbinding the device.
> 
> Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian

--000000000000b9614705b57ef7fb
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
NBgcnL8bS1GD7jRZUdtUvDm/XhPjv+5arhlrB5NmaKDsRaobcoQ0vtEyAnImSb64+wEvXgPF3y7V
0LCIoQMCAwEAAaOCAdQwggHQMA4GA1UdDwEB/wQEAwIFoDCBngYIKwYBBQUHAQEEgZEwgY4wTQYI
KwYBBQUHMAKGQWh0dHA6Ly9zZWN1cmUuZ2xvYmFsc2lnbi5jb20vY2FjZXJ0L2dzcGVyc29uYWxz
aWduMnNoYTJnM29jc3AuY3J0MD0GCCsGAQUFBzABhjFodHRwOi8vb2NzcDIuZ2xvYmFsc2lnbi5j
b20vZ3NwZXJzb25hbHNpZ24yc2hhMmczME0GA1UdIARGMEQwQgYKKwYBBAGgMgEoCjA0MDIGCCsG
AQUFBwIBFiZodHRwczovL3d3dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzAJBgNVHRMEAjAA
MEQGA1UdHwQ9MDswOaA3oDWGM2h0dHA6Ly9jcmwuZ2xvYmFsc2lnbi5jb20vZ3NwZXJzb25hbHNp
Z24yc2hhMmczLmNybDAoBgNVHREEITAfgR1mbG9yaWFuLmZhaW5lbGxpQGJyb2FkY29tLmNvbTAT
BgNVHSUEDDAKBggrBgEFBQcDBDAfBgNVHSMEGDAWgBRpcoJiMWeVRIV3kYDEBDZJnXsLYTAdBgNV
HQ4EFgQUjDSG6itHmsBGYhab0ncHg6PidD0wDQYJKoZIhvcNAQELBQADggEBAJD+OK9GMwW86kdo
oTOaDH8VAbGtc3cvxHH/zTSRaq+XQOUwzXeB35AgKQ7VnnW+AYsU0NILbJUrAUGctIt4fMgPi+fZ
1SJxTyzKxS0LCahS3l9aL3TEWyFOnDurmKeLcgVG5qMVXysLYDXiUGGg1I/zmOHefpv30RDNdUjD
9oUbBggB6IHlL4Y6x21gV6Cduse0xOgMrY+dXhntQimTLmuPz0b3uUVJNdtTqVG5pZwZZ/cjsGCm
QTlT5kx0VnHRHhYKS+1b2usAYk+pec77Wth9xL1gsEGVh4JmIdQpkhqGHA/m2nVkhW/WbbFsA7Im
9CNMvmz2hVgGGipcf47g+EsxggJvMIICawIBATBtMF0xCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBH
bG9iYWxTaWduIG52LXNhMTMwMQYDVQQDEypHbG9iYWxTaWduIFBlcnNvbmFsU2lnbiAyIENBIC0g
U0hBMjU2IC0gRzMCDE64Wkk+BtY98mx37TANBglghkgBZQMEAgEFAKCB1DAvBgkqhkiG9w0BCQQx
IgQgCe0rNE/gu4F2iMflekC2RvUsUovFbc76TLB+OjWKpcwwGAYJKoZIhvcNAQkDMQsGCSqGSIb3
DQEHATAcBgkqhkiG9w0BCQUxDxcNMjAxMjAyMTc1NjUwWjBpBgkqhkiG9w0BCQ8xXDBaMAsGCWCG
SAFlAwQBKjALBglghkgBZQMEARYwCwYJYIZIAWUDBAECMAoGCCqGSIb3DQMHMAsGCSqGSIb3DQEB
CjALBgkqhkiG9w0BAQcwCwYJYIZIAWUDBAIBMA0GCSqGSIb3DQEBAQUABIIBAHD2TQJkBFDdaKpx
5IwGKRdVSCqafYi9EbCZzUnQGtDBQcWOUsgmkubyGiXUBajp1o/l2XBtjK4hRRi7VrDaF0f52yRw
8QgxPWS6edKoaZuNQAtBbDLBv0g+V7xNFdqF6AvCVuCTjUPqbRYhJ7twF5sMX0iu0E9pyRAGInMz
1QkHTwJ1sWQo7q5NG3mOHcSmitC8kyab2HLNa+GG18qPBO0HeVmR0P52EGoMWmELqJjKsMu6kJrv
KBD2Ot6IW+hwXySsmcoiE19J+wZT0BE1oh7fkf8wbu3FQsk2u1VPCzstBCXwg72H0BAsHj8HAZFW
+VX7ZvY68bRYsgHPurwWEZE=
--000000000000b9614705b57ef7fb--
