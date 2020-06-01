Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CDA41EA032
	for <lists+linux-pwm@lfdr.de>; Mon,  1 Jun 2020 10:37:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728247AbgFAIhp (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 1 Jun 2020 04:37:45 -0400
Received: from mout.web.de ([212.227.15.3]:58225 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726142AbgFAIho (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Mon, 1 Jun 2020 04:37:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1591000645;
        bh=443Hq2HPlgJiFQQQ7keR6nHLyv8izXj6cs1nNOXWoOY=;
        h=X-UI-Sender-Class:Cc:Subject:To:From:Date;
        b=qMDSPL/yfrVBHgofxkLbxl8tO6YYuL3xPeY3Gv+95ZSs1b8zdWjaMxk6VGMaVD/Xt
         OXnQfA4inO2ap7KV0ZpVE7hBxDyOO8VKkYiL3zyiHQp5JTGuJt5DwUWZIHE+PazVVz
         XHhIw5JDTUJIOx90dXQOEAecvcNnyc2DTdH4QYWU=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.49.133.32]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MW9ra-1jVEUB2zN4-00XbUu; Mon, 01
 Jun 2020 10:37:25 +0200
Cc:     Navid Emamdoost <emamd001@umn.edu>, Kangjie Lu <kjlu@umn.edu>,
        Qiushi Wu <wu000273@umn.edu>,
        Stephen McCamant <smccaman@umn.edu>,
        Dinghao Liu <dinghao.liu@zju.edu.cn>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] pwm: img: call pm_runtime_put in pm_runtime_get_sync
 failed case
To:     Navid Emamdoost <navid.emamdoost@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        linux-pwm@vger.kernel.org
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <166b2437-748a-1c1a-2b7f-e1163e4855d0@web.de>
Date:   Mon, 1 Jun 2020 10:37:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:EGSFtVu3Zec5yU0hXypJVihgHAoseeXVttRVcc/oxi3Fff90Zvh
 HEvTmVbYkcnXXd3Gm0uG0t0TYno758ftf7tIoRs46ENkWNj7nZU44lKEblyvIeQ41oSH1ei
 ZaEX++XGKnnDwVi0vZa9KK6qE3jLGOBq8HMz7TtSFTynaCdJiiEwgVCAfqDJoNbb3Gj0iij
 OcBQB0qn3lnOX/aZQ1x4g==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:WXVs/5qNz5k=:mJdWac6p+fWRiEuH1hR0CM
 DZJXz8EvWvDAPSZfqVz/o8uY7UUywFOsw1VE9U7cvyVD86YqMmp6oqkIFWRLUOHGb7b1JavUa
 Hj6+VrAXcD9g1rVZp0BWccCKdHv/Ml85Xu1oVNifPsqIzRLoDKKJ5c5iA/YsEKYZGDzAkvpGY
 OUtv8/Vk8V3Y54FNWaUxP0FI5MusgP2iq2s7lqMsHT4hpzoVQu4lUb/0H8EQLXVN4pxW0s+FG
 Jm2+36Pc0W+mP5t9GgB/L86Jn1fzEGO/Q2uHMFOp/ioVK+f46IOwir3JQNNd2OqOir/zFYNS+
 Q5YEW0ySGl1u/Uqg6gmAVH1yZE7/dgoT9l95IqjSrJLp9/GaFTqbe1ho/+jkBaf8jdocj1K6N
 1w0FzlDUsamXXPqvaJrGjZdS5lnSELFw2aI9BHGjdNnvdav5dnOo39dknNDMVxKkc8E1HK9mi
 k5b2UguiWBjN0bUSQBCD7GV+/2xm7V4Xf9nF7ZUuOwoG8CReOAgKkRu5zN7uQ2RIwVehfNr2Y
 xb6LwCyqiJLriUXhW7J8QzD4tREOw6spdV8pAZW8DImV4btAzc071O3ClrbZ5YxZX/rrJNlc/
 J0uZZ+gis+uIwmM8w5f9asfOE+5W+dG+iNxHwExgKR9hI40n7til11Vi/A/4+bAJcIzyCwRoM
 Q3c6mZSaq2spwQyAffNfZ55/ZFu2Pq0eJf+M/j+z8Wi9Uu44LbOFpPTpVnq5Hh+KAcbDUXjM7
 0hnZV4kli8AfO4dbAWcp9mfoAf1sWb9bg3HfTvIOUUOoSetJqmPHMLReeoTUiCOucjUFq15Fu
 A3lzyzs5TArnfxE89oB9ooN+NCLmsOt8ldQ4kJtZv+V4wG/xhNYdEq94f8qy8RQQ0w+LDy73S
 SUq2X2OLttBwpmEp68Z5ep/kCBoLfW8P2sCEbJqfo2f/uwPoKru07VoYl0DVHJyDE4Ia4+gLj
 rRVlUkBgXnzAEDi2AQkBOGNsThP9UFlevsHT4l2nBKvEUHyHR+XfPs4NRYdCui74Ei68vjvGP
 9l+LgnFO8DMsXewiqKp7shfl64Y5GvVFqORM5OKXGxl/yTCz25ZfNh4ZqQsIP2k479wm+ZN85
 +NWv+Xjsz5rpho7K8iBrusGPJ9+Q/6xzqg0JQJ2pAAHWn7CcO40ckcPJzDla4vowsc+LOLlZJ
 FBdeH6XZ3lLW+zLUzCk+gSCjMm0KVanTeVAnbP/HEOAx1IeR1BsysMGZSL9LyUbwO4z6+zxCJ
 NJslfhYMs4SfBh5NR
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

> Even in failed case of pm_runtime_get_sync, the usage_count
> is incremented. In order to keep the usage_count with correct
> value call appropriate put.

* I suggest to adjust the word =E2=80=9Cusage_count=E2=80=9D in this chang=
e description.

* Would you like to add the tag =E2=80=9CFixes=E2=80=9D to the commit mess=
age?

Regards,
Markus
